
vim.cmd("autocmd!")
vim.cmd([[ command! U Lazy update ]])

--UTF-8
vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

--numberline
vim.wo.number = true
vim.wo.relativenumber = true

--Opt
vim.opt.title = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.hlsearch = true
vim.opt.backup = false
vim.opt.showcmd = true
vim.opt.cmdheight = 1
vim.opt.laststatus = 2
vim.opt.expandtab = true
vim.opt.scrolloff = 10
vim.opt.shell = "/bin/fish"
vim.opt.backupskip = { "/tmp/*", "/private/tmp/*" }
vim.opt.inccommand = "split"
vim.opt.ignorecase = true
vim.opt.smarttab = true
vim.opt.breakindent = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.wrap = false
vim.opt.backspace = { "start", "eol", "indent" }
vim.opt.path:append({ "**" })
vim.opt.wildignore:append { '*/node_modules/*' }
vim.opt.pumheight = 15
vim.opt.swapfile = false
vim.opt.signcolumn = "yes"
vim.opt.numberwidth = 2
vim.opt.shortmess:append "c"
vim.opt.list = true

--indent_blankline
vim.g.indent_blankline_use_treesitter = true

--Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

--clipboard
vim.opt.clipboard:append({ "unnamedplus" })


--Comment
vim.cmd [[autocmd BufEnter * set fo-=c fo-=r fo-=o]]


vim.api.nvim_create_autocmd({ "BufReadPost" }, {
    pattern = { "*" },
    callback = function()
        vim.api.nvim_exec('silent! normal! g`"zv', false)
    end,
})
