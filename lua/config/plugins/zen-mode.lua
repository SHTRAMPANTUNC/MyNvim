return {
    "folke/zen-mode.nvim",
    enabled = PREF.plugins.zen_mode,
    keys = {
        { "<leader>z", ":ZenMode<CR>", silent = true },
    },
    config = function()
        require("zen-mode").setup({
            window = {
                backdrop = 0.8,
                width = 120,
                options = {
                    cursorline = false,
                    number = false,
                    relativenumber = false,
                    cursorcolumn = false,
                    list = false,
                },
            },
            plugins = {
                gitsigns = true,
                tmux = true,
            },
        })
    end,
}
