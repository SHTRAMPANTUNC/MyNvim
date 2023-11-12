return {
	{
		"nvim-treesitter/nvim-treesitter",
		enable = true,
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"c",
					"cpp",
					"lua",
					"json",
					"cmake",
                    "python",
				},
				ignore_install = {},
				highlight = {
					enable = true,
					disable = { "help" },
				},
				indent = {
					enable = true,
				},
			})
		end,
	},
}
