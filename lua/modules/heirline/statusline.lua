local conditions = require("heirline.conditions")
local utils = require("heirline.utils")
local colors = require("catppuccin.palettes").get_palette("mocha")

local bg = colors.base

local mode_init = function(self)
	self.mode = vim.fn.mode(1)
end

local block_color = function(self)
	self.mode_color = self.mode_colors[self.mode:sub(1, 1)]
end

local mode_color = {
	n = colors.blue,
	i = colors.green,
	v = colors.red,
	V = colors.red,
	[""] = colors.red,
	Vs = colors.red,
	c = colors.yellow,
	s = colors.yellow,
	S = colors.yellow,
	["\19"] = colors.yellow,
	r = colors.orange,
	R = colors.orange,
	["!"] = colors.orange,
	t = colors.overlay2,
}

local ViMode = {
	init = mode_init,
	hl = block_color,
	static = {
		mode_names = {
			n = "NORMAL",
			no = "NORMAL",
			nov = "NORMAL",
			noV = "NORMAL",
			["no\22"] = "NORMAL",
			niI = "NORMAL",
			niR = "NORMAL",
			niV = "NORMAL",
			nt = "NORMAL",
			v = "VISUAL",
			vs = "VISUAL",
			V = "VISUAL",
			Vs = "VISUAL",
			["\22"] = "VISUAL",
			["\22s"] = "VISUAL",
			s = "SELECT",
			S = "SELECT",
			["\19"] = "SELECT",
			i = "INSERT",
			ic = "INSERT",
			ix = "INSERT",
			R = "REPLACE",
			Rc = "REPLACE",
			Rx = "REPLACE",
			Rv = "REPLACE",
			Rvc = "REPLACE",
			Rvx = "REPLACE",
			c = "COMMAND",
			cv = "Ex",
			r = "...",
			rm = "M",
			["r?"] = "?",
			["!"] = "!",
			t = "TERM",
		},
		mode_colors = mode_color,
	},
	{
		provider = function()
			return " "
		end,
		hl = function(self)
			return { bg = self.mode_color }
		end,
	},
	{
		provider = function(self)
			return " %2(" .. self.mode_names[self.mode] .. "%) "
		end,
		hl = function(self)
			return { fg = colors.base, bg = self.mode_color, bold = true }
		end,
	},
	{
		provider = function()
			return " "
		end,
		hl = function(self)
			return { bg = self.mode_color }
		end,
	},
}

local FileNameBlock = {
	init = function(self)
		self.filename = vim.api.nvim_buf_get_name(0)
	end,
}

local FileIcon = {
	{
		provider = function()
			return " "
		end,
		hl = function(self)
			return { bg = colors.surface0 }
		end,
	},
	{
		init = function(self)
			local filename = self.filename
			local extension = vim.fn.fnamemodify(filename, ":e")
			self.icon, self.icon_color =
				require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
		end,
		provider = function(self)
			return self.icon and (self.icon .. " ")
		end,
		hl = function(self)
			return { fg = colors.text, bg = colors.surface0 }
		end,
	},
}

local FileName = {
	{
		init = function(self)
			self.lfilename = vim.fn.fnamemodify(self.filename, ":t")
			if self.lfilename == "" then
				self.lfilename = "[No Name]"
			end
		end,
		provider = function(self)
			return self.lfilename
		end,
		hl = { fg = colors.text, bg = colors.surface0 },
	},
}

local FileFlags = {
	{
		condition = function()
			return vim.bo.modified
		end,
		provider = " [+]",
		hl = { fg = colors.text, bg = colors.surface0 },
	},
	{
		provider = function()
			return " "
		end,
		hl = function(self)
			return { bg = colors.surface0 }
		end,
	},
}

local FileNameModifer = {
	hl = function()
		if vim.bo.modified then
			return { fg = colors.text, bg = colors.surface0 }
		end
		return { fg = colors.text, bg = colors.surface0 }
	end,
}

FileNameBlock = utils.insert(
	FileNameBlock,
	utils.insert(FileNameModifer, FileIcon, FileName), -- a new table where FileName is a child of FileNameModifier
	FileFlags,
	{ provider = "%<" }
)

local Git_branch = {
	condition = conditions.is_git_repo,
	init = function(self)
		self.status_dict = vim.b.gitsigns_status_dict
	end,
	hl = function()
		return { fg = colors.overlay2, bg = colors.mantle, bold = true }
	end,
	{
		provider = function()
			return " "
		end,
	},
	{
		condition = function(self)
			return not conditions.buffer_matches({
				filetype = self.filetypes,
			})
		end,
		{
			provider = function(_)
				return " "
			end,
		},
		{
			provider = function(self)
				return self.status_dict.head
			end,
		},
		{
			provider = function(self)
				local count = self.status_dict.added or 0
				return count > 0 and string.format("   %s", count)
			end,
		},
		{
			provider = function(self)
				local count = self.status_dict.removed or 0
				return count > 0 and string.format("   %s", count)
			end,
		},
		{
			provider = function(self)
				local count = self.status_dict.changed or 0
				return count > 0 and string.format("   %s", count)
			end,
		},
	},
}

local Diagnostics = {
	condition = conditions.has_diagnostics,
	init = function(self)
		self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
		self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
		self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
	end,
	update = { "DiagnosticChanged", "BufEnter" },
	-- Errors
	{
		condition = function(self)
			return self.errors > 0
		end,
		{
			{
				provider = function(self)
					return vim.fn.sign_getdefined("DiagnosticSignError")[1].text .. self.errors .. " "
				end,
			},
		},
	},
	-- Warnings
	{
		condition = function(self)
			return self.warnings > 0
		end,
		{
			{
				provider = function(self)
					return vim.fn.sign_getdefined("DiagnosticSignWarn")[1].text .. self.warnings .. " "
				end,
			},
		},
	},
	-- Info
	{
		condition = function(self)
			return self.info > 0
		end,
		{
			{
				provider = function(self)
					return " " .. vim.fn.sign_getdefined("DiagnosticSignInfo")[1].text .. self.info .. " "
				end,
			},
		},
	},
}

local LSPActive = {
	condition = conditions.lsp_attached,
	update = { "LspAttach", "LspDetach" },
	{
		provider = function()
			return " "
		end,
		hl = { fg = colors.overlay2, bg = colors.mantle, bold = true },
	},
	{
		provider = function()
			local names = {}
			---@diagnostic disable-next-line
			for _, server in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
				table.insert(names, server.name)
			end
			return "   LSP ~ " .. table.concat(names, ", ")
		end,
		hl = { fg = colors.overlay2, bg = colors.mantle, bold = true },
	},
	{
		provider = function()
			return " "
		end,
		hl = { fg = colors.overlay2, bg = colors.mantle, bold = true },
	},
}

local WorkDir = {
	provider = function()
		local icon = " 󰉋 "
		local cwd = vim.fn.getcwd(0)
		cwd = vim.fn.fnamemodify(cwd, ":t")
		if not conditions.width_percent_below(#cwd, 0.25) then
			cwd = vim.fn.pathshorten(cwd)
		end
		return " " .. icon .. cwd .. "  "
	end,
	hl = function(self)
		return { fg = colors.text, bg = colors.surface0, bold = true }
	end,
}

local Progress = {
	init = mode_init,
	hl = block_color,
	static = {
		mode_colors = mode_color,
	},
	{
		hl = function(self)
			return { bg = self.mode_color, fg = colors.base }
		end,
		provider = function(self)
			local line_fraction = math.floor(vim.fn.line(".") / vim.fn.line("$") * 100)
			local value = string.format("%2d%%%%", line_fraction)
			if line_fraction <= 0 then
				value = "Top"
			elseif line_fraction >= 100 then
				value = "Bot"
			end
			return "  " .. value .. "  "
		end,
	},
}

return {
	-- Left
	ViMode,
	FileNameBlock,
	Git_branch,
	--------------------
	{ provider = "%=" },
	{ provider = "%=" },
	--------------------
	-- Right
	Diagnostics,
	LSPActive,
	WorkDir,
	Progress,
}
