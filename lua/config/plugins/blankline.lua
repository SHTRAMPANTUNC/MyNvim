return {
	{
		{
			"lukas-reineke/indent-blankline.nvim",
			event = { "BufReadPost", "BufNewFile" },
			config = function()
				require("ibl").setup({
					indent = {
						char = "│",
						tab_char = "│",
					},
					scope = {
						show_start = false,
						show_end = false,
					},
					exclude = {
						filetypes = {
							"help",
							"alpha",
							"NvimTree_1",
							"text",
							"markdown",
							"gitconfig",
							"Trouble",
							"lazy",
							"mason",
							"notify",
							"asm",
						},
					},
				})
			end,
			main = "ibl",
		},

		{
			"echasnovski/mini.indentscope",
			enabled = true,
			version = false,
			event = { "BufReadPre", "BufNewFile" },
			opts = {
				symbol = "│",
				options = { try_as_border = true },
			},
			init = function()
				vim.api.nvim_create_autocmd("FileType", {
					pattern = {
						"help",
						"alpha",
						"dashboard",
						"NvimTree",
						"Trouble",
						"lazy",
						"mason",
						"notify",
						"toggleterm",
						"lazyterm",
					},
					callback = function()
						vim.b.miniindentscope_disable = true
					end,
				})
			end,
		},
	},
}
