local config = function()
	local npairs = require'nvim-autopairs'
	local Rule   = require'nvim-autopairs.rule'
	local cond = require'nvim-autopairs.conds'

	require("nvim-autopairs").setup({
		check_ts = true,
		enable_check_bracket_line = true,
		iignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=],
		disable_filetype = { "TelescopePrompt" },
	})

	-- Before	 Input	  After
	-- `(|)`	`space`	  `( | )`
	-- `( | )`	  `)`	  `(  )|`

	local brackets = { { '(', ')' }, { '[', ']' }, { '{', '}' }, { '<', '>' }}
	npairs.add_rules {
	  Rule(' ', ' ')
		:with_pair(function (opts)
		  local pair = opts.line:sub(opts.col - 1, opts.col)
		  return vim.tbl_contains({
			brackets[1][1]..brackets[1][2],
			brackets[2][1]..brackets[2][2],
			brackets[3][1]..brackets[3][2],
			brackets[4][1]..brackets[4][2],
		  }, pair)
		end)
	}

end


return config
