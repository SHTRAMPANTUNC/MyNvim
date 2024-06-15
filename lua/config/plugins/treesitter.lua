return {
	{
		"nvim-treesitter/nvim-treesitter",
		enable = true,
		lazy = false,
		dependencies = {
			{
				"nvim-treesitter/nvim-treesitter-context",
				config = function()
					require("treesitter-context").setup({
						enable = true,
						max_lines = 1,
					})
				end,
			},
			{
				"nvim-treesitter/nvim-treesitter-textobjects",
				config = function()
					require("nvim-treesitter.configs").setup({
						textobjects = {
							select = {
								enable = true,
								keymaps = {
									["af"] = "@function.outer",
									["if"] = "@function.inner",
									["ac"] = "@class.outer",
									["ic"] = { query = "@class.inner" },
									["as"] = { query = "@scope", query_group = "locals" },
								},
								swap = {
									enable = true,
									swap_next = {
										["<leader>a"] = "@parameter.inner",
									},
									swap_previous = {
										["<leader>A"] = "@parameter.inner",
									},
								},
							},
						},
					})
				end,
			},
		},
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"c",
					"go",
					"cpp",
					"lua",
					"nix",
					"json",
					"yaml",
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
