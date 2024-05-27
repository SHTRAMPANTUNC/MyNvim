return {
	{
		"akinsho/bufferline.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		enabled = not vim.g.started_by_firenvim,
		event = { "BufRead", "BufNewFile" },
		config = function()
			vim.opt.termguicolors = true
			require("bufferline").setup({
				options = {
					indicator = {
						icon = " ",
						style = "icon",
					},
					modified_icon = " ",
					left_trunc_marker = "",
					right_trunc_marker = "",
					max_name_length = 25,
					max_prefix_length = 15,
					tab_size = 25,
					diagnostics = "nvim_lsp",
					custom_filter = function(bufnr)
						local exclude_ft = { "qf", "fugitive", "git" }
						local cur_ft = vim.bo[bufnr].filetype
						local should_filter = vim.tbl_contains(exclude_ft, cur_ft)

						if should_filter then
							return false
						end

						return true
					end,
					show_buffer_icons = true,
					show_buffer_close_icons = false,
					show_tab_indicators = true,
					persist_buffer_sort = true,
					separator_style = "thin",
					enforce_regular_tabs = false,
					always_show_bufferline = true,
					sort_by = "id",
				},
			})
		end,
	},
}
