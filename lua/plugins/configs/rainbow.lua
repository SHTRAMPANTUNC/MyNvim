return {
	{
		"hiphish/rainbow-delimiters.nvim",
		event = { "BufRead", "BufNewFile" },
		config = function()
			local rainbow_delimiters = require("rainbow-delimiters")

			vim.g.rainbow_delimiters = {
				strategy = {
					[""] = rainbow_delimiters.strategy["global"],
					vim = rainbow_delimiters.strategy["local"],
				},
				query = {
					[""] = "rainbow-delimiters",
					lua = "rainbow-blocks",
				},
				highlight = {
					"RainbowDelimiterRed",
					"RainbowDelimiterYellow",
					"RainbowDelimiterBlue",
					"RainbowDelimiterOrange",
					"RainbowDelimiterGreen",
					"RainbowDelimiterViolet",
					"RainbowDelimiterCyan",
				},
			}
		end,
	},

	vim.api.nvim_set_hl(0, "RainbowDelimiterRed", { fg = "#c84053" }),
	vim.api.nvim_set_hl(0, "RainbowDelimiterYellow", { fg = "#de9800" }),
	vim.api.nvim_set_hl(0, "RainbowDelimiterBlue", { fg = "#4d699b" }),
	vim.api.nvim_set_hl(0, "RainbowDelimiterGreen", { fg = "#6e915f" }),
	vim.api.nvim_set_hl(0, "RainbowDelimiterCyan", { fg = "#d7e3d8" }),
}
