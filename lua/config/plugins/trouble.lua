return {
	{
		"folke/trouble.nvim",
		event = "LspAttach",
        enabled = true,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("trouble").setup({
				auto_fold = false,
				fold_open = " ",
				fold_closed = " ",
				height = 8,
				indent_str = " ┊   ",
				include_declaration = {
					"lsp_references",
					"lsp_implementations",
					"lsp_definitions",
				},
				mode = "workspace_diagnostics",
				multiline = true,
				padding = false,
				position = "bottom",
				severity = nil,
				use_diagnostic_signs = true,
			})
		end,
	},
}
