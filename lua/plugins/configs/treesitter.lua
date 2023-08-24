require("nvim-treesitter.configs").setup {
  ensure_installed = { "python", "cpp", "lua", "tsx", "json", "cmake","typescript","javascript","css","html" },
  ignore_install = {},
  highlight = {
    enable = true,
    disable = { 'help' },
  },
}

