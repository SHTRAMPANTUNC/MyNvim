
--Core req
require("core.base")
require("plugins.lazy")
require("core.mapping")
require("core.colors")

--Plugins req
-- -ui
require("plugins.configs.ui.nvimtree")
require("plugins.configs.ui.icon")
require("plugins.configs.ui.buffers")
require("plugins.configs.ui.lualine")
require("plugins.configs.ui.dashboard")
-- -editor
require("plugins.configs.editor.hop")
require("plugins.configs.editor.autopairs")
require("plugins.configs.editor.comments")
require("plugins.configs.editor.cmp")
-- -git
require("plugins.configs.git.gitsings")
require("plugins.configs.git.git")
-- -other
require("plugins.configs.treesitter")
require("plugins.configs.telescope")
require("plugins.configs.toggleterm")
require("plugins.configs.trouble")
require("plugins.configs.zen")

--LSP req
require("lsp.lspconfig")
require("lsp.lspsaga")
require("lsp.null-ls")
require("lsp.mason")


--(╯°□°）╯︵ ┻━┻)
