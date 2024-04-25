local lsp = require("lspconfig")
local capabilities = require("config.lsp.handlers").capabilities
local on_attach = require("config.lsp.handlers").on_attach

--LSP SETUP
for _, server in ipairs(PREF.lsp.install_servers) do
    lsp[server].setup({
        capabilities = capabilities,
        on_attach = on_attach,
    })
end

lsp.clangd.setup({
    on_attach = on_attach,
    cmd = require("config.lsp.settings.clangd").cmd,
    init_options = require("config.lsp.settings.clangd").init_options,
    filetypes = require("config.lsp.settings.clangd").filetypes
})

lsp.lua_ls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = require("config.lsp.settings.lua_ls").settings,
})

lsp.jsonls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = require("config.lsp.settings.jsonls").settings,
})

lsp.gopls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = require("config.lsp.settings.gopls").settings,
})
