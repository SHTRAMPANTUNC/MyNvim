return {
	{
		"neovim/nvim-lspconfig",
		enable = true,
		event = {
			"BufReadPost",
			"BufNewFile",
		},
		dependencies = {
			"b0o/schemastore.nvim",
		},
		config = function()
            require("config.lsp.init")
        end,
	},
}
