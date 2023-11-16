return {
	{
		"phaazon/hop.nvim",
		branch = "v2",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("hop").setup()
			local hop = require("hop")
			local directions = require("hop.hint").HintDirection
			vim.keymap.set("", "f", function()
				hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
			end, { remap = true })
			vim.keymap.set("", "F", function()
				hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
			end, { remap = true })
		end,
	},
},
	vim.api.nvim_create_autocmd("ColorScheme", {
		pattern = "*",
		callback = function()
			vim.cmd([[
      hi HopNextKey cterm=bold ctermfg=176 gui=bold  guifg=#748fc7
      hi HopNextKey1 cterm=bold ctermfg=176 gui=bold guifg=#748fc7
      hi HopNextKey2 cterm=bold ctermfg=176 gui=bold guifg=#748fc7
    ]])
		end,
	})
