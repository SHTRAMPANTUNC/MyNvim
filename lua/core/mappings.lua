local cb = require("utils").lazy_rhs_cb
local u = require("utils")
local map = vim.keymap.set

vim.g.mapleader = PREF.mapleader

-- ##################################################
-- ####			  NEOVIM KEYBINDINGS		     ####
-- ##################################################

map("n", "x", '"_x', { desc = "Better X bind" })
map("n", "q", "<Cmd>close<CR>", { desc = "CLose current window" })

map("n", "<C-j>", ":wincmd h<CR>", { silent = true, desc = "Focus Right" })
map("n", "<C-k>", ":wincmd l<CR>", { silent = true, desc = "Focus Left" })
map("n", "<C-l>", ":wincmd j<CR>", { silent = true, desc = "Focus Bottom" })
map("n", "<C-;>", ":wincmd k<CR>", { silent = true, desc = "Focus Top" })

map("n", "<Tab>", ":bnext<CR>", { silent = true })
map("n", "<S-Tab>", ":bprev<CR>", { silent = true })
map("n", "<leader>x", ":bd|bp<CR>", { silent = true })

map("n", "\\", ":vsplit<Return><C-w>w", { silent = true, desc = "Split Window" })


-- ##################################################
-- ####			  MOVEMENT KEYBINDINGS		     ####
-- ##################################################

map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, desc = "Move cursor down (display and real line)" })
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, desc = "Move cursor up (display and real line)", })

map({ "n", "x" }, "H", "^", { desc = "Go to start line" })
map({ "n", "x" }, "L", "g_", { desc = "Go to end line" })


-- ##################################################
-- ####			  EDIROR KEYBINDINGS		     ####
-- ##################################################

map("x", "p", '"_c<Esc>p', { desc = "Paste without copy into register" })

map("n", "<C-a>", "gg<S-v>G", { desc = "Select All" })

map("x", "<S-Tab>", "<gv", { desc = "Move Indent Forward" })
map("x", "<Tab>", ">gv|", { desc = "Move Indent Back" })

map({ "i" }, "<C-k>", "<Esc>C", { desc = "Delete one letter after cursor" })

-- TODO: Fix MoveLine Binds 
map("n", "<A-j>", require("modules.move_line").move_line("+"), { silent = true, desc = "Move line to Top" })
map("n", "<A-k>", require("modules.move_line").move_line("-"), { silent = true, desc = "Move line to Down" })
map("x", "<A-j>", require("modules.move_line").move_selected("+"), { silent = true, desc = "Move Group of line to Top" })
map("x", "<A-k>", require("modules.move_line").move_selected("-"), { silent = true, desc = "Move Group of line to Down" })

--Surround
map("v", "<leader>sa", cb("modules.surround", "add_visual"))
map("n", "<leader>sa", cb("modules.surround", "add"))
map("n", "<leader>sd", cb("modules.surround", "remove"))
map("n", "<leader>sc", cb("modules.surround", "replace"))

map("n", "<Leader>t", cb("modules.toggler", "toggle_word"), { desc = "Module Toggler: toggle word under cursor" })

-- ##################################################
-- ####			  PLUGINS KEYBINDINGS	         ####
-- ##################################################

--Tree
map("n", "<C-n>", ":NvimTreeToggle<CR>", { silent = true })

--Comments
map("n", "<C-x>", function() require("Comment.api").toggle.linewise.current() end, { desc = "comment toggle" })
map("v", "<C-x>", "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", { desc = "comment toggle" })

--Trouble
map("n", "<leader>d", ":Trouble diagnostics toggle focus=true<CR>", { silent = true })

-- ##################################################
-- ####			  GIT KEYBINDINGS	             ####
-- ##################################################

map("n", "<leader>gn", ":Neogit<CR>", { silent = true })

map({ "n", "v" }, "<leader>gl", function()
	local mode = string.lower(vim.fn.mode())
	require("gitlinker").get_buf_range_url(mode)
end, {
	silent = true,
	desc = "get git permlink",
})

map("n", "<leader>gb", function()
	require("gitlinker").get_repo_url({
		action_callback = require("gitlinker").actions.open_in_browser,
	})
end, {
	silent = true,
	desc = "browse repo in browser",
})

-- ##################################################
-- ####			  OTHER KEYBINDINGS	             ####
-- ##################################################

map("n", "<leader>cd", "<cmd>lcd %:p:h<cr><cmd>pwd<cr>", { desc = "Change current working directory locally and print cwd after that," } )
map("n", "<leader>sp", "<cmd>set spell!<cr>", { desc = "Toggle Spell" })

map("n", "C", '"_C', { desc = "'C' without copying to clipboard" })
map("n", "D", '"_D', { desc = "'D' without copying to clipboard" })
map("n", "dw", 'vb"_d', { desc = "Delete a word backwards" })

map("x", "/", "<Esc>/\\%V", { desc = "Search in visual region" })

