return {
	"nvim-tree/nvim-tree.lua",
	event = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("nvim-tree").setup({
			sort_by = "case_sensitive",
			view = {
				width = 35,
			},
			hijack_cursor = false,
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
	end,
}
