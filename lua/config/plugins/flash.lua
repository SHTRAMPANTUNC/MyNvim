return {
	{
		"folke/flash.nvim",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			highlight = {
				matches = false,
				priority = 5000,
			},
		},
	},
},
	vim.api.nvim_create_autocmd("ColorScheme", {
		pattern = "*",
		callback = function()
			vim.cmd([[
      hi FlashLabel cterm=bold ctermfg=176 gui=bold  guifg=#748fc7
    ]])
		end,
	})
