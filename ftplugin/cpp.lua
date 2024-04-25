vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

--Compile file
vim.api.nvim_set_keymap("n", "<F5>", "<cmd>lua compile_run_cpp()<CR>", { silent = true })

function compile_run_cpp()
	local src_path = vim.fn.expand("%:p:~")
	local src_noext = vim.fn.expand("%:p:~:r")
	local _flag = "-std=c++20 -O2"

	local prog = ""
	if vim.fn.executable("clang++") == 1 then
		prog = "clang++"
	elseif vim.fn.executable("g++") == 1 then
		prog = "g++"
	else
		vim.api.nvim_err_writeln("No C++ compiler found on the system!")
		return
	end

	vim.api.nvim_command("botright 10new")
	vim.api.nvim_command("resize " .. 10)

	local command = string.format("term %s %s %s -o %s && %s", prog, _flag, src_path, src_noext, src_noext)
	vim.api.nvim_command(command)

	vim.api.nvim_command("startinsert")
end
