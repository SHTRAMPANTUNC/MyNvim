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
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash Jump",
			},
			{
				"S",
				mode = { "n", "o", "x" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote Flash",
			},
			{
				"R",
				mode = { "o", "x" },
				function()
					require("flash").treesitter_search()
				end,
				desc = "Flash Treesitter Search",
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
