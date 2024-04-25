PREF = {
    common = {
        textwidth = 130,
        tabwidth = 2,
    },

    lsp = {
        diagnostic = {
            underline = false,
            format_on_save = false,
            signs = true,
            virtual_text = false,
            severity_sort = true,
        },
        install_servers = {
            "clangd",
            "cmake",
            "lua_ls",
            "jsonls",
            "nil_ls",
            "gopls",
        },
    },

    plugins = { -- <--- enable/disable optional plugins
        mason = false, -- disable for NixOS
        wakatime = false,
        markdown_preview = false,
        zen_mode = true,
    },

    ui = {
        signs = {
            Error = "🤮",
            Warn  = "🤢",
            Hint  = "🤯",
            Info  = "🤓",
        },
        colorscheme = "catppuccin",
        border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    }
}
