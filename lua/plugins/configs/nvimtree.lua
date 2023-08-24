-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- empty setup using defaults
require("nvim-tree").setup()

-- OR setup with some options
require("nvim-tree").setup({
	sort_by = "case_sensitive",
	view = {
		width = 40,
	},
	renderer = {
		group_empty = true,
		full_name = true,
		indent_markers = {
			enable = true,
		},
	},
	filters = {
		dotfiles = true,
	},
	diagnostics = {
		enable = true,
		show_on_dirs = true,
	},
})
