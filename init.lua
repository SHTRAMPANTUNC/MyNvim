--Options
require("core.options")

--KeyBinding
require("core.mappings")

--Autocmd
require("core.autocmd")

--Plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local configs = "plugins.configs"

--(╯°□°)╯︵ ┻━┻
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--single-branch",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end

vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup(configs, {
	defaults = {
		lazy = true,
	},
	install = {
		colorscheme = { "kanagawa" },
	},
	ui = {
		border = "rounded",
		title = "Plugin Manager",
		title_pos = "center",
		icons = {
			cmd = " ",
			config = "",
			event = "",
			ft = " ",
			init = " ",
			import = " ",
			keys = " ",
			lazy = "󰂠 ",
			loaded = "●",
			not_loaded = "○",
			plugin = " ",
			runtime = " ",
			source = " ",
			start = "",
			task = "✔ ",
			list = {
				"●",
				"➜",
				"★",
				"‒",
			},
		},
	},
})
