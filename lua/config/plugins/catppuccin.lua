return {
	{
		"catppuccin/nvim",
		lazy = false,

		config = function()
			require("catppuccin").setup({
				flavour = "mocha",
				no_underline = true,
				styles = {
					comments = { "italic" },
					conditionals = { "italic" },
					functions = { "bold" },
					keywords = { "italic" },
				},
				color_overrides = {
					mocha = {
						base = "#181825",
					},
				},
				highlight_overrides = {
					all = {
						NvimTreeFolderIcon = { fg = "#de9860" },
						NormalFloat = { bg = "none" },
					},
				},
				integrations = {
					cmp = true,
					alpha = true,
					flash = true,
					gitsigns = true,
					nvimtree = true,
					treesitter = true,
					notify = true,
				},
			})
			vim.cmd.colorscheme("catppuccin")
		end,
	},
}
