local M = {}

M.move_line = function(op)
	return function()
		local start = op == "+" and 1 or 2
		local count = vim.v.count
		local times = count == 0 and start or (op == "+" and count or count + 1)
		local ok, _ = pcall(vim.cmd.move, op .. times)
		if ok then
			vim.cmd.norm("==")
		end
	end
end

M.move_selected = function(op)
	return function()
        local restore_autocmd = require("utils").disable_autocmd("toggle_relnum")

		local start = op == "+" and "" or 2
		local count = vim.v.count
		local times = count == 0 and start or (op == "+" and count or count + 1)
		local mark = op == "+" and "'>" or "'<"
		vim.api.nvim_feedkeys(vim.keycode(":move" .. mark .. op .. times .. "<Cr>gv=gv"), "n", true)

		restore_autocmd()
	end
end

return M
