local textwidth = PREF.common.textwidth
local tabwidth = PREF.common.tabwidth

local options = {
	-- ===============================
	-- Other
	-- ===============================
	title = true,
	backup = false,
	backupskip = { "/tmp/*", "/private/tmp/*" },
	inccommand = "split",
	wrap = false,
	backspace = { "start", "eol", "indent" },
	clipboard = "unnamedplus",
	path = vim.opt.path:append({ "**" }),
	wildignore = vim.opt.wildignore:append({ "*/node_modules/*" }),
	swapfile = false,
	smoothscroll = true,
	spell = fasle,
	spelllang = "en_us,ru_ru",
	mouse = "",
	splitright = true,
	updatetime = 1000,
	splitbelow = true,

	-- ===============================
	-- UTF-8
	-- ===============================
	encoding = "utf-8",
	fileencoding = "utf-8",

	-- ===============================
	-- Search
	-- ===============================
	hlsearch = true,
	infercase = true,
	ignorecase = true,
	smartcase = true,
	grepprg = "rg --vimgrep",

	-- ===============================
	-- Indent&Tabs
	-- ===============================
	expandtab = true,
	cindent = true,
	smarttab = true,
	shiftwidth = tabwidth,
	tabstop = tabwidth,

	-- ===============================
	-- UI
	-- ===============================
	cursorline = true,
	colorcolumn = tostring(textwidth),
    signcolumn = "yes",
    laststatus = 3,
    showcmd = false,
    scrolloff = 10,
	number = true,
	relativenumber = true,
	numberwidth = 2,
	termguicolors = true,
	winblend = 0,
	pumheight = 15,
	wildoptions = "pum",
	pumblend = 5,
}

for option_name, value in pairs(options) do
	local ok, _ = pcall(vim.api.nvim_get_option_info2, option_name, {})
	if ok then
		vim.opt[option_name] = value
	else
		vim.notify("Option " .. option_name .. " is not supported", vim.log.levels.WARN)
	end
end
