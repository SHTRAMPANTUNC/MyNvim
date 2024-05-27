PREF = {
    common = {
        textwidth = 130,
        tabwidth = 2,
    },

    mapleader = " ",

    lsp = {
        diagnostic = {
            underline = false,
            format_on_save = false,
            signs = true,
            virtual_text = false,
            severity_sort = true,
        },
        install_servers = {
            "cmake",
            "gopls",
            "nil_ls",
            "lua_ls",
            "jsonls",
            "clangd",
            "dockerls",
            "pyright",
        },
    },

    plugins = {  -- NOTE: <--- enable/disable optional plugins
        mason = false, -- disable for NixOS
        wakatime = false,
        markdown_preview = false,
        zen_mode = true,
    },

    ui = {
        signs = {
            Error = "🤮",
            Warn = "🤢",
            Hint = "🤯",
            Info = "🤓",
        },
        dashboard = {
            [[███████╗██╗  ██╗████████╗██████╗  █████╗ ███╗   ███╗██████╗  █████╗ ███╗   ██╗████████╗██╗   ██╗███╗   ██╗ ██████╗]],
            [[██╔════╝██║  ██║╚══██╔══╝██╔══██╗██╔══██╗████╗ ████║██╔══██╗██╔══██╗████╗  ██║╚══██╔══╝██║   ██║████╗  ██║██╔════╝]],
            [[███████╗███████║   ██║   ██████╔╝███████║██╔████╔██║██████╔╝███████║██╔██╗ ██║   ██║   ██║   ██║██╔██╗ ██║██║     ]],
            [[╚════██║██╔══██║   ██║   ██╔══██╗██╔══██║██║╚██╔╝██║██╔═══╝ ██╔══██║██║╚██╗██║   ██║   ██║   ██║██║╚██╗██║██║     ]],
            [[███████║██║  ██║   ██║   ██║  ██║██║  ██║██║ ╚═╝ ██║██║     ██║  ██║██║ ╚████║   ██║   ╚██████╔╝██║ ╚████║╚██████╗]],
            [[╚══════╝╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝╚═╝     ╚═╝  ╚═╝╚═╝  ╚═══╝   ╚═╝    ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝]],
        },
    },
}
