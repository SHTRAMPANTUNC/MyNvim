return {
	"rebelot/kanagawa.nvim",
	priority = 1000,
	event = "VimEnter",
	build = ":KanagawaCompile",

	config = function()
		require("kanagawa").setup({
			compile = true,
			undercurl = true,
			commentStyle = { italic = true },
			functionStyle = { bold = true },
			keywordStyle = { italic = true },
			statementStyle = { bold = true },
			typeStyle = {},
			transparent = false,
			dimInactive = false,
			terminalColors = true,
			theme = "wave",
			background = {
				dark = "wave",
				light = "lotus",
			},
		})

		vim.cmd("colorscheme kanagawa")
        
		vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
		vim.api.nvim_set_hl(0, "signcolumn", { bg = "none" })
		vim.api.nvim_set_hl(0, "Visual", { bg = "#363647" })
		vim.api.nvim_set_hl(0, "GitSignsAdd", { bg = "none" })
		vim.api.nvim_set_hl(0, "GitSignsChanged", { bg = "none" })
		vim.api.nvim_set_hl(0, "GitSignsDelete", { bg = "none" })
		vim.api.nvim_set_hl(0, "GitSignsChange", { bg = "none" })
		vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { bg = "none" })
		vim.api.nvim_set_hl(0, "DiagnosticSignHint", { bg = "none" })
		vim.api.nvim_set_hl(0, "DiagnosticSignError", { bg = "none" })
	end,
}
