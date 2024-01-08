return {
	{
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
			telescope.load_extension("projects")
			local function telescope_buffer_dir()
				return vim.fn.expand("%:p:h")
			end

			telescope.setup({
				defaults = {
					layout_config = {
						horizontal = {
							prompt_position = "top",
							preview_width = 0.55,
							results_width = 0.8,
						},
						vertical = {
							mirror = false,
						},
						width = 0.69,
						height = 0.75,
						preview_cutoff = 120,
					},
					find_command = {
						"rg",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
					},
					prompt_prefix = "   ",
					selection_caret = "  ",
					entry_prefix = "  ",
					initial_mode = "insert",
					selection_strategy = "reset",
					sorting_strategy = "ascending",
					layout_strategy = "horizontal",
					file_sorter = require("telescope.sorters").get_fuzzy_file,
					file_ignore_patterns = {},
					generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
					path_display = {},
					winblend = 0,
					border = {},
					borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
					color_devicons = true,
					use_less = true,
					set_env = { ["COLORTERM"] = "truecolor" },
					file_previewer = require("telescope.previewers").vim_buffer_cat.new,
					grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
					qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
					buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
				},
			})

			vim.keymap.set("n", ";f", function()
				builtin.find_files({
					no_ignore = false,
					hidden = true,
				})
			end)

			vim.keymap.set("n", ";r", function()
				builtin.current_buffer_fuzzy_find()
			end)
			vim.keymap.set("n", ";g", function()
				builtin.live_grep()
			end)
			vim.keymap.set("n", ";h", function()
				builtin.keymaps()
			end)
			vim.keymap.set("n", ";b", function()
				builtin.buffers()
			end)
		end,
	},

	{
		"ahmedkhalf/project.nvim",
		config = function()
			require("project_nvim").setup({})
		end,
	},
}
