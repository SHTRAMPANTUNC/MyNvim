local status_ok, lsp = pcall(require, "lspconfig")
if not status_ok then
    return
end

for _, server in pairs(PREF.lsp.install_servers) do
    local opts = {
        on_attach = require('config.lsp.handlers').on_attach,
        capabilities = require('config.lsp.handlers').capabilities,
    }
    local has_server_opts, server_opts = pcall(require, "config.lsp.settings." .. server)
    if has_server_opts then
        opts = vim.tbl_deep_extend("force", server_opts, opts)
    end
    lsp[server].setup(opts)
end
