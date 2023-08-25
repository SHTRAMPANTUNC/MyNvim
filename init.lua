--Core req
require("core.base")
require("plugins.init")
require("core.mapping")
require("core.colors")

--Plugins req
require("plugins.configs.nvimtree")
require("plugins.configs.hop")
require("plugins.configs.buffers")
require("plugins.configs.autopairs")
require("plugins.configs.cmp")
require("plugins.configs.treesitter")
require("plugins.configs.telescope")
require("plugins.configs.dashboard")
require("plugins.configs.comments")
require("plugins.configs.gitsings")
require("plugins.configs.toggleterm")
require("plugins.configs.lualine")
require("plugins.configs.trouble")
require("plugins.configs.git")

--LSP req
require("lsp.lspconfig")
require("lsp.lspsaga")
require("lsp.null-ls")
require("lsp.mason")


vim.cmd [[autocmd BufEnter * set fo-=c fo-=r fo-=o]]
