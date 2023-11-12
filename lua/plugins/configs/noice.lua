return {
	{
		"folke/noice.nvim",
		event = "VimEnter",
		opts = {
			lsp = {
				signature = {
					enabled = true,
				},
			},
			presets = {
				lsp_doc_border = true,
			},
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
			{
				"rcarriga/nvim-notify",
				config = function()
					require("notify").setup({
						minimum_width = 50,
						background_colour = "#1d2021",
						stages = "static",
						render = "minimal",
						timeout = 1500,
					})
					local notify = require("notify")
					vim.notify = notify
				end,
			},
		},

		config = function()
			require("noice").setup({
				routes = {
					{
						filter = {
							event = "msg_show",
							kind = "",
							find = "written",
						},
						opts = { skip = true },
					},
				},
			})
		end,
	},

	vim.api.nvim_set_hl(0, "NoiceCmdlineIcon", { fg = "#dcd7ba" }),

	vim.api.nvim_set_hl(0, "NoiceCmdlinePopupTitle", { fg = "#dcd7ba" }),

	vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder", { fg = "#dcd7ba" }),
}
