local lsp = require("lspconfig")
local servers = require("user_settings").lsp.install_servers
local capabilities = require("plugins.lsp.handlers").capabilities
local on_attach = require("plugins.lsp.handlers").on_attach

--LSP SETUP
for _, server in ipairs(servers) do
	lsp[server].setup({
		capabilities = capabilities,
		on_attach = on_attach,
	})
end

lsp.clangd.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		cmd = require("plugins.lsp.settings.clangd").cmd,
})

lsp.lua_ls.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		settings = require("plugins.lsp.settings.lua_ls").settings,
})

lsp.jsonls.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		settings = require("plugins.lsp.settings.jsonls").settings,
})

lsp.ltex.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		settings = require("plugins.lsp.settings.ltex").settings,
})
