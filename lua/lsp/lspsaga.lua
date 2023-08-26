local status, saga = pcall(require, "lspsaga")
if (not status) then return end

saga.setup({
  ui = {
    border = 'rounded',
    code_action = "🤯", 
    sign = true
  },
  symbol_in_winbar = {
    enable = true
  },
  lightbulb = {
    enable = true,
  },
  outline = {
    layout = 'float'
  }
})

--LSP-Map
local diagnostic = require("lspsaga.diagnostic")
local opts = { noremap = true, silent = true }
		vim.keymap.set("n", "K", ":Lspsaga hover_doc<CR>", opts)
		vim.keymap.set("n", "gd", ":Lspsaga goto_definition<CR>", opts)
		vim.keymap.set("n", "gf", ":Lspsaga finder<CR>", opts)
		vim.keymap.set("n", "ga", ":Lspsaga code_action<CR>", opts)
		vim.keymap.set("n", "<leader>so", ":Lspsaga outline<CR>", opts)
		vim.keymap.set("n", "gr", ":Lspsaga rename<CR>", opts)
    vim.keymap.set('i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.keymap.set('n', '<Leader>lf',function() vim.lsp.buf.format {async = true} end, opts)

