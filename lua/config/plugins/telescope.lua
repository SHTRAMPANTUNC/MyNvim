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
					vimgrep_arguments = {
						"rg",
						"-L",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
					},
					prompt_prefix = "   ",
					color_devicons = true,
					layout_config = {
						horizontal = {
							prompt_position = "top",
							preview_width = 0.55,
							results_width = 0.8,
						},
						width = 0.87,
						height = 0.80,
						preview_cutoff = 120,
					},
					selection_caret = "  ",
					path_display = { "smart" },
					mappings = {
						n = {
							["q"] = actions.close,
						},
					},
				},
			-- 	pickers = {
			-- 		current_buffer_fuzzy_find = {
			-- 			layout_config = {
			-- 				width = 0.5,
			-- 				height = 0.8,
			-- 			},
			-- 			previewer = false,
			-- 		},
			-- 		live_grep = {
			-- 			layout_config = {
			-- 				width = 0.5,
			-- 				height = 0.8,
			-- 			},
			-- 			previewer = false,
			-- 		},
			-- 	},
			})

			extensions = {}

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
