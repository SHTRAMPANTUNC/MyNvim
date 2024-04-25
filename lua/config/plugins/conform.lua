return {
    "stevearc/conform.nvim",
    event = "BufRead",
    opts = {},
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                lua = { "stylua" },
                cpp = { "clang_format" },
                nix = { "alejandra" },
                go = { "gofmt", "goimports" },
            },
        })
    end,
}
