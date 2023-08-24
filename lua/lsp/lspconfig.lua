local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- Sntup language servers.
local lspconfig = require("lspconfig")
lspconfig.pyright.setup({})
lspconfig.cmake.setup({})
lspconfig.tsserver.setup({
	on_attach = on_attach,
	filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
	cmd = { "typescript-language-server", "--stdio" },
	capabilities = capabilities,
})

lspconfig.cssls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

lspconfig.tailwindcss.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

require("lspconfig").clangd.setup({
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
	init_option = { fallbackFlags = { "-std=c++2a" } },
	capabilities = custom_capabilities,
})

vim.diagnostic.config({
  virtual_text = {
    prefix = '●'
  },
  update_in_insert = true,
  float = {
    source = "always", -- Or "if_many"
  },
})

--LSP Diagnostic
vim.fn.sign_define("DiagnosticSignError", { texthl = "DiagnosticSignError", text = "🤮", numhl = "" })
vim.fn.sign_define("DiagnosticSignWarn", { texthl = "DiagnosticSignWarn", text = "🤢", numhl = "" })
vim.fn.sign_define("DiagnosticSignHint", { texthl = "DiagnosticSignHint", text = "🤯", numhl = "" })
vim.fn.sign_define("DiagnosticSignInfo", { texthl = "DiagnosticSignInfo", text = "🤔", numhl = "" })
