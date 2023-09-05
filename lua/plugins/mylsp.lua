return {
	"neovim/nvim-lspconfig",
	enable = true,
	event = { "BufEnter" },
	config = function()
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

		-- Sntup language servers.
		local lsp = require("lspconfig")

		lsp.pyright.setup({})

		lsp.tsserver.setup({
			on_attach = on_attach,
			filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
			cmd = { "typescript-language-server", "--stdio" },
			capabilities = capabilities,
		})

		lsp.cssls.setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})

		lsp.tailwindcss.setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})

		lsp.clangd.setup({
			cmd = {
				"clangd",
				"--offset-encoding=utf-16",
				"--completion-style=detailed",
				"--background-index", --Clangd settings
				"-j=4",
				"--pch-storage=memory",
				"--header-insertion=never",
			},
			filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
			on_attach = custom_attach,
			capabilities = custom_capabilities,
		})

		vim.diagnostic.config({
			virtual_text = {
				prefix = "●",
			},
			update_in_insert = true,
			float = {
				source = "if_many", -- Or "if_many"
			},
		})

		vim.fn.sign_define("DiagnosticSignError", { texthl = "DiagnosticSignError", text = "🤮", numhl = "" })
		vim.fn.sign_define("DiagnosticSignWarn", { texthl = "DiagnosticSignWarn", text = "🤢", numhl = "" })
		vim.fn.sign_define("DiagnosticSignHint", { texthl = "DiagnosticSignHint", text = "🤯", numhl = "" })
		vim.fn.sign_define("DiagnosticSignInfo", { texthl = "DiagnosticSignInfo", text = "🤔", numhl = "" })
	end,
}
