return {
	"rebelot/heirline.nvim",
	event = "VimEnter",
	enabled = not vim.g.started_by_firenvim,
	config = function()
		require("heirline").setup({
			statusline = require("modules.heirline.statusline"),
			tabline = require("modules.heirline.tabline"),
		})
	end,
}
