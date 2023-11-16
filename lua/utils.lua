local M = {}

---Checking if the string in lowercase
---@return boolean

function M.move_line(op)
	return function()
		local start = op == "+" and 1 or 2
		local count = vim.v.count
		local times = count == 0 and start or (op == "+" and count or count + 1)
		local ok, _ = pcall(vim.cmd.move, op .. times)
		if ok then
			vim.cmd.norm("==")
		end
	end
end

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

return M
