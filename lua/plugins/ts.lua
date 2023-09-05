return {
	"nvim-treesitter/nvim-treesitter",
	enable = true,
    event = "VeryLazy",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"python",
				"c",
				"cpp",
				"lua",
				"tsx",
				"json",
				"cmake",
				"typescript",
				"javascript",
				"css",
				"html",
			},
			ignore_install = {},
			highlight = {
				enable = true,
				disable = { "help" },
			},
		})

		local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
		parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
	end,
}
