return {

    {
        "catppuccin/nvim",
        lazy = false,

        config = function()
            local mocha = require("catppuccin.palettes").get_palette("mocha")

            require("catppuccin").setup({
                flavour = "mocha",
                no_underline = true,
                styles = {
                    comments = { "italic" },
                    conditionals = { "italic" },
                    functions = { "bold" },
                    keywords = { "italic" },
                },
                color_overrides = {
                    mocha = {
                        base = "#181825",
                    },
                },
                highlight_overrides = {
                    mocha = {
                        NormalFloat = { bg = "none" },

                        NvimTreeFolderIcon = { fg = mocha.peach },
                        NvimTreeGitStagedIcon = { fg = mocha.green },
                        NvimTreeGitNewIcon = { fg = mocha.green },

                        ["@keyword.import.cpp"] = { fg = mocha.red },
                        ["@namespace"] = { fg = mocha.yellow },
                        ["@string.cmake"] = { fg = mocha.red },
                        ["@constant.cmake"] = { fg = mocha.green },
                    },
                },
                integrations = {
                    cmp = true,
                    vimwiki = true,
                    alpha = true,
                    flash = true,
                    gitsigns = true,
                    nvimtree = true,
                    lsp_saga = true,
                    treesitter = true,
                    notify = true,
                },
            })
            vim.cmd.colorscheme(PREF.ui.colorscheme)
        end,
    },
}
