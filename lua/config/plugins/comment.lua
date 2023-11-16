return {
	{
		"folke/todo-comments.nvim",
		event = { "BufReadPost", "BufNewFile" },
		opts = {},
	},

	{
		"numToStr/Comment.nvim",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = "folke/todo-comments.nvim",
		config = function()
			require("Comment").setup({
				toggler = {
					---Line-comment toggle keymap
					line = "<C-x>",
					---Block-comment toggle keymap
					block = "gcc",
				},
				mappings = {
					basic = true,
					extra = true,
				},
				pre_hook = nil,
				post_hook = nil,
			})
		end,
	},
}
