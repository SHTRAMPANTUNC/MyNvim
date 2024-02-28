return {
    "stevearc/conform.nvim",
    event = "BufRead",
    opts = {},
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                lua = { "stylua" },
                nix = { "alejandra" },
                cpp = { "clang_format" },
            },
            --[[ vim.api.nvim_create_autocmd("BufWritePre", {
                pattern = "*",
                callback = function(args)
                    require("conform").format({ bufnr = args.buf })
                end,
            }), ]]
        })
    end,
}
