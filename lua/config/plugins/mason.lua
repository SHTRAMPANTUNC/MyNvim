local settings = {
    ui = {
        border = PREF.ui.border,
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
        enabled = PREF.plugins.mason,
        build = ":MasonUpdate",
        event = "VeryLazy",
        config = function()
            require("mason").setup(settings)
            require("mason-lspconfig").setup({
                ensure_installed = PREF.lsp.install_servers,
                automatic_installation = true,
            })
        end,
    },
}
