return {
	{
		"rebelot/kanagawa.nvim",
		priority = 1000,
		lazy = false,
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
				theme = "wave", -- or dragon
				background = "wawe",

				overrides = function(colors)
					return {
						LineNr = { bg = "none" },
						Visual = { bg = "#363647" },
						signcolumn = { bg = "none" },

						NormalFloat = { bg = "none" },
						FloatBorder = { bg = "none" },
						FloatTitle = { bg = "none" },

						GitSignsAdd = { bg = "none" },
						GitSignsDelete = { bg = "none" },
						GitSignsChange = { bg = "none" },
						GitSignsChanged = { bg = "none" },

						DiagnosticSignError = { bg = "none" },
						DiagnosticSignWarn = { bg = "none" },
						DiagnosticSignHint = { bg = "none" },
						DiagnosticSignInfo = { bg = "none" },

						NvimTreeFolderIcon = { fg = "#de9860" },
					}
				end,
			})
			vim.cmd("colorscheme kanagawa")
		end,
	},
}
