local M = {}

---Checking if the string in lowercase
---@return boolean

function M.is_lower(str)
	return str == string.lower(str)
end

function M.get_object_range()
	local start = vim.api.nvim_buf_get_mark(0, "[")
	local end_ = vim.api.nvim_buf_get_mark(0, "]")
	end_[2] = end_[2] + 1

	return vim.tbl_flatten({ start, end_ })
end

local function char_byte_count(s, i)
	if not s or s == "" then
		return 1
	end

	local char = string.byte(s, i or 1)
	if char > 0 and char <= 127 then
		return 1
	elseif char >= 194 and char <= 223 then
		return 2
	elseif char >= 224 and char <= 239 then
		return 3
	elseif char >= 240 and char <= 244 then
		return 4
	end
end

function M.lazy_rhs_cb(module, cb_name, ...)
	local args = { ... }
	return function()
		if #args == 0 then
			return require(module)[cb_name]()
		else
			return require(module)[cb_name](unpack(args))
		end
	end
end

function M.char_on_pos(pos)
	pos = pos or vim.fn.getpos(".")
	return tostring(vim.fn.getline(pos[1])):sub(pos[2], pos[2])
end

function M.get_visual_range()
	local sr, sc = unpack(vim.fn.getpos("v"), 2, 3)
	local er, ec = unpack(vim.fn.getpos("."), 2, 3)

	-- To correct work with non-single byte chars
	local byte_c = char_byte_count(M.char_on_pos({ er, ec }))
	ec = ec + (byte_c - 1)

	local range = {}

	if sr == er then
		local cols = sc >= ec and { ec, sc } or { sc, ec }
		range = { sr, cols[1] - 1, er, cols[2] }
	elseif sr > er then
		range = { er, ec - 1, sr, sc }
	else
		range = { sr, sc - 1, er, ec }
	end

	return range
end

function M.to_api_range(range)
	local sr, sc, er, ec = unpack(range)
	return sr - 1, sc, er - 1, ec
end

function M.split_padline(line, side)
	side = side or "both"
	local is_left = side == "both" and true or side == "left"
	local is_right = side == "both" and true or side == "right"
	local pad_left, pad_right = "", ""

	if is_left then
		local start, end_ = line:find("^%s+")
		if start then
			pad_left = line:sub(start, end_)
			line = line:sub(end_ + 1)
		end
	end

	if is_right then
		local start, end_ = line:find("%s+$")
		if start then
			pad_right = line:sub(start, end_)
			line = line:sub(1, -(#pad_right + 1))
		end
	end

	return pad_left, line, pad_right
end

---Feedkeys witn 'n' (noremap) mode and auto 'replace_termcodes'
---@param f string
function M.feedkeys(f)
	local term = vim.api.nvim_replace_termcodes(f, true, true, true)
	vim.api.nvim_feedkeys(term, "n", true)
end

M.root_patterns = {
	".git/",
	"Makefile",
	"makefile",
	"CMakeLists.txt",
	"MAKEFILE",
	".gitignore",
}

---@param path string?
---@param patterns string[]? root patterns
---@return string? nil if not found
function M.proj_dir(path, patterns)
	if not path or path == "" then
		return nil
	end
	patterns = patterns or M.root_patterns
	---@diagnostic disable-next-line: undefined-field
	local stat = vim.uv.fs_stat(path)
	if not stat then
		return
	end
	local dirpath = stat.type == "directory" and path or vim.fs.dirname(path)
	for _, pattern in ipairs(patterns) do
		local root = vim.fs.find(pattern, {
			path = dirpath,
			upward = true,
			type = pattern:match("/$") and "directory" or "file",
		})[1]
		if root and vim.uv.fs_stat(root) then
			local dirname = vim.fs.dirname(root)
			return dirname and vim.uv.fs_realpath(dirname) --[[@as string]]
		end
	end
end

---@param group number|string Group name or id
---@return function Callback to restore cleared group's autocmds
function M.disable_autocmd(group)
	local ok, aus = pcall(vim.api.nvim_get_autocmds, { group = group })
	if ok then
		vim.api.nvim_clear_autocmds({ group = group })
		local function make_opts(au)
			local opts = {
				group = au.group,
				desc = au.desc,
				once = au.once,
				pattern = au.pattern,
			}

			if au.command ~= "" then
				opts.command = au.command
			else
				opts.callback = au.callback
			end

			return opts
		end

		return function()
			vim.defer_fn(function()
				for _, au in ipairs(aus) do
					vim.api.nvim_create_autocmd(au.event, make_opts(au))
				end
			end, 0)
		end
	else
		return function() end
	end
end

return M
