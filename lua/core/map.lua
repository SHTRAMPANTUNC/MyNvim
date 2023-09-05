
local keymap = vim.keymap
vim.g.mapleader = " "

-- ##################################################
-- ####			       NEOVIM KEYBINDINGS			       ####
-- ##################################################

keymap.set("n", "x", '"_x')

keymap.set("i", "jj", "<ESC>")

keymap.set("n", "<C-q>", ":q!<CR>")
keymap.set("n", "<C-s>", ":noautocmd w!<CR>")

-- Increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Delete a word backwards
keymap.set("n", "dw", 'vb"_d')

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Save with root permission (not working for now)
--vim.api.nvim_create_user_command('W', 'w !sudo tee > /dev/null %', {})

-- Split window
keymap.set("n", "ss", ":split<Return><C-w>w")
keymap.set("n", "sv", ":vsplit<Return><C-w>w")

-- focus direction
keymap.set("n", "<C-j>", ":wincmd h<CR>", { silent = true }) -- focus right
keymap.set("n", "<C-k>", ":wincmd l<CR>", { silent = true }) -- focus left
keymap.set("n", "<C-l>", ":wincmd j<CR>", { silent = true }) -- focus bottom
keymap.set("n", "<C-;>", ":wincmd k<CR>", { silent = true }) -- focus top

-- ##################################################
-- ####			     PLUGINS KEYBINDINGS			       ####
-- ##################################################

--Tree
keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>", { silent = true })

--Tabs
keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>", { silent = true })
keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { silent = true })
keymap.set("n", "<leader>x", ":BufferLinePickClose<CR>", { silent = true })

--Terminal
keymap.set("n", "\\", ":ToggleTerm direction=float<CR>", opts)
keymap.set("t", "\\", "exit<CR>", opts)

--Cmake
keymap.set("n", "<leader>cg", ':CMakeGenera -G "Ninja"<CR>')
keymap.set("n", "<leader>cb", ":CMakeBuild --config Release<CR>")
keymap.set("n", "<leader>ci", ":CMakeInstall<CR>")
keymap.set("n", "<leader>ct", ":CMakeTest<CR>")
keymap.set("n", "<leader>cq", ":CMakeClose<CR>")

--Trouble
vim.keymap.set("n", "<leader>d", ":Trouble<CR>")

--Codeium
vim.keymap.set('i', '<C-g>', function () return vim.fn ['codeium#Accept']() end, { expr = true })
vim.keymap.set('i', '<c-;>', function() return vim.fn  ['codeium#CycleCompletions'](1) end, { expr = true })
vim.keymap.set('i', '<c-,>', function() return vim.fn  ['codeium#CycleCompletions'](-1) end, { expr = true })
vim.keymap.set('i', '<c-x>', function() return vim.fn  ['codeium#Clear']() end, { expr = true })
