return {
	{
		{
			"lukas-reineke/indent-blankline.nvim",
			event = { "BufReadPost", "BufNewFile" },
			config = function()
				require("ibl").setup({
					indent = { char = "▏" },
					scope = {
						show_start = false,
						show_end = false,
					},
					exclude = {
						filetypes = {
							"help",
							"alpha",
							"dashboard",
							"NvimTree_1",
							"neo-tree",
							"Trouble",
							"lazy",
							"mason",
							"notify",
							"toggleterm",
							"lazyterm",
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
			version = false, -- wait till new 0.7.0 release to put it back on semver
			event = { "BufReadPre", "BufNewFile" },
			opts = {
				symbol = "▏",
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
