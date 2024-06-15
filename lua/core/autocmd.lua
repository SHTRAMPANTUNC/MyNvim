local autocmd = vim.api.nvim_create_autocmd
local groupid = vim.api.nvim_create_augroup

---@param group string
---@vararg { [1]: string|string[], [2]: vim.api.keyset.create_autocmd }
---@return nil
local function augroup(group, ...)
  local id = groupid(group, {})
  for _, a in ipairs({ ... }) do
    a[2].group = id
    autocmd(unpack(a))
  end
end

vim.cmd("autocmd TermOpen * setlocal norelativenumber nonumber")
vim.cmd("autocmd TermOpen * startinsert")
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

autocmd({ "InsertLeave", "WinEnter" }, {
	callback = function()
		local ok, cl = pcall(vim.api.nvim_win_get_var, 0, "auto-cursorline")
		if ok and cl then
			vim.wo.cursorline = true
			vim.api.nvim_win_del_var(0, "auto-cursorline")
		end
	end,
})

autocmd({ "InsertEnter", "WinLeave" }, {
	callback = function()
		local cl = vim.wo.cursorline
		if cl then
			vim.api.nvim_win_set_var(0, "auto-cursorline", cl)
			vim.wo.cursorline = false
		end
	end,
})

autocmd("BufEnter", {
	desc = "Rid auto comment for new string",
	callback = function()
		vim.opt.formatoptions:remove({ "c", "r", "o" })
	end,
})

autocmd("TextYankPost", {
	desc = "Highlight copied text",
	callback = function()
		vim.highlight.on_yank({ higroup = "PmenuSel", timeout = 100 })
	end,
})

autocmd("BufWinEnter", {
	desc = "Open :help with vertical split",
	pattern = { "*.txt" },
	callback = function()
		if vim.bo.filetype == "help" then
			vim.cmd.wincmd("L")
		end
	end,
})

autocmd("BufHidden", {
	desc = "Delete [No Name] buffers",
	callback = function(data)
		if data.file == "" and vim.bo[data.buf].buftype == "" and not vim.bo[data.buf].modified then
			vim.schedule(function()
				pcall(vim.api.nvim_buf_delete, data.buf, {})
			end)
		end
	end,
})

--Off highlight search
autocmd("User", {
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

autocmd({ "VimEnter", "DirChanged" }, {
	callback = function()
		vim.schedule(check_git_repo)
	end,
})

autocmd("BufReadPost", {
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

autocmd({ "InsertLeave" }, {
    callback = function()
        vim.fn.execute("silent! write")
    end,
})

augroup('AutoCwd', {
  { 'BufWinEnter', 'FileChangedShellPost' },
  {
    pattern = '*',
    desc = 'Automatically change local current directory.',
    callback = function(info)
      if info.file == '' or vim.bo[info.buf].bt ~= '' then
        return
      end
      local buf = info.buf
      local win = vim.api.nvim_get_current_win()

      vim.schedule(function()
        if
          not vim.api.nvim_buf_is_valid(buf)
          or not vim.api.nvim_win_is_valid(win)
          or not vim.api.nvim_win_get_buf(win) == buf
        then
          return
        end
        vim.api.nvim_win_call(win, function()
          local current_dir = vim.fn.getcwd(0)
          local target_dir = require('utils').proj_dir(info.file)
            or vim.fs.dirname(info.file)
          local stat = target_dir and vim.uv.fs_stat(target_dir)
          if
            stat
            and stat.type == 'directory'
            and current_dir ~= target_dir
          then
            pcall(vim.cmd.lcd, target_dir)
          end
        end)
      end)
    end,
  },
})
