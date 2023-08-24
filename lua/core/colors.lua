vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.winblend = 0
vim.opt.wildoptions = "pum"
vim.opt.pumblend = 5
vim.opt.background = "dark"

vim.cmd([[
  augroup highlight_yank
  autocmd!
  au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Visual", timeout=100})
  augroup END
]])

vim.cmd.colorscheme("kanagawa")

function SetColor(color)
	color = color
	vim.cmd.colorscheme(color)
	vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
end

SetColor()


--Kanagawa settings
require("kanagawa").setup({
	compile = true,
	undercurl = true,
	commentStyle = { italic = true },
	functionStyle = { bold = true },
	keywordStyle = { italic = true },
	statementStyle = { bold = true },
	typeStyle = {},
	transparent = false,
	dimInactive = false,
	terminalColors = true,
	theme = "wave",
	background = {
		dark = "wave",
		light = "lotus",
	},
})
