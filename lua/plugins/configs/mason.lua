local servers = require("user_settings").lsp.install_servers

local settings = {
	ui = {
		border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
		width = 0.6,
		height = 0.7,
		icons = {
			package_installed = "󰄳",
			package_pending = "",
			package_uninstalled = "󰚌",
		},
	},
}

return {
	{
		"williamboman/mason.nvim",
		dependencies = { "williamboman/mason-lspconfig.nvim" },
		build = ":MasonUpdate",
		event = "VeryLazy",
		config = function()
			require("mason").setup(settings)
			require("mason-lspconfig").setup({
				ensure_installed = servers,
				automatic_installation = true,
			})
		end,
	},
}
