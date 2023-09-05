return {
	"williamboman/mason.nvim",
	build = ":MasonUpdate",
    event = "VeryLazy",
	config = function()
		require("mason").setup({

			ensure_installed = {
				-- lua stuff
				"lua-language-server",
				"stylua",

				-- web dev stuff
				"css-lsp",
				"html-lsp",
				"typescript-language-server",
				"deno",
				"prettier",

				-- c/cpp stuff
				"clangd",
				"clang-format",
			},

			ui = {
				icons = {
					package_installed = "󰄳",
					package_pending = "",
					package_uninstalled = "󰚌",
				},
			},
		})
	end,
}
