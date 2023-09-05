return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.2",
	enable = true,
	event = "UIEnter",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local status, telescope = pcall(require, "telescope")
		if not status then
			return
		end
		local actions = require("telescope.actions")
		local builtin = require("telescope.builtin")

		local function telescope_buffer_dir()
			return vim.fn.expand("%:p:h")
		end

		telescope.setup({
			defaults = {
				prompt_prefix = "  ",
				layout_config = {
					horizontal = {
						prompt_position = "top",
						preview_width = 0.55,
						results_width = 0.8,
					},
				},
				selection_caret = " ",
				path_display = { "smart" },
				mappings = {
					n = {
						["q"] = actions.close,
					},
				},
			},
		})

		extensions = {}

		vim.keymap.set("n", ";f", function()
			builtin.find_files({
				no_ignore = false,
				hidden = true,
			})
		end)

		vim.keymap.set("n", ";r", function()
			builtin.live_grep()
		end)
		vim.keymap.set("n", ";t", function()
			builtin.help_tags()
		end)
		vim.keymap.set("n", ";h", function()
			builtin.keymaps()
		end)
	end,
}
