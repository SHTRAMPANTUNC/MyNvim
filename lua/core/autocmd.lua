vim.cmd("autocmd TermOpen * setlocal norelativenumber nonumber")
vim.cmd("autocmd TermOpen * startinsert")

vim.cmd("autocmd BufRead,BufNewFile *.h,*.c set filetype=c.doxygen")

vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

vim.api.nvim_create_autocmd("BufEnter", {
	desc = "Rid auto comment for new string",
	callback = function()
		vim.opt.formatoptions:remove({ "c", "r", "o" })
	end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight copied text",
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 100 })
	end,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
	desc = "Open :help with vertical split",
	pattern = { "*.txt" },
	callback = function()
		if vim.bo.filetype == "help" then
			vim.cmd.wincmd("L")
		end
	end,
})

vim.api.nvim_create_autocmd("BufHidden", {
	desc = "Delete [No Name] buffers",
	callback = function(data)
		if data.file == "" and vim.bo[data.buf].buftype == "" and not vim.bo[data.buf].modified then
			vim.schedule(function()
				pcall(vim.api.nvim_buf_delete, data.buf, {})
			end)
		end
	end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
	desc = "Override messages when buffer is written",
	callback = function()
		vim.api.nvim_echo({ { "File has been saved" } }, fasle, {})
	end,
})

--Off highlight search
vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
		require("modules.key_listener")
	end,
})

--Turn on plugin in Git Reposetori
local function check_git_repo()
	local cmd = "git rev-parse --is-inside-work-tree"
	if vim.fn.system(cmd) == "true\n" then
		vim.api.nvim_exec_autocmds("User", { pattern = "InGitRepo" })
		return true
	end
end

vim.api.nvim_create_autocmd({ "VimEnter", "DirChanged" }, {
	callback = function()
		vim.schedule(check_git_repo)
	end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
	desc = "Jump to the last place you’ve visited in a file before exiting",
	callback = function()
		local ignore_ft = { "NvimTree_1", "toggleterm", "lazy" }
		local ft = vim.bo.filetype
		if not vim.tbl_contains(ignore_ft, ft) then
			local mark = vim.api.nvim_buf_get_mark(0, '"')
			local lcount = vim.api.nvim_buf_line_count(0)
			if mark[1] > 0 and mark[1] <= lcount then
				pcall(vim.api.nvim_win_set_cursor, 0, mark)
			end
		end
	end,
})
