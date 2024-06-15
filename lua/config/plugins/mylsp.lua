return {
	{
		"neovim/nvim-lspconfig",
		enable = true,
        event = { "VeryLazy" },
		dependencies = {
			"b0o/schemastore.nvim",
		},
		config = function()
            require("config.lsp.init")
        end,
	},
}
