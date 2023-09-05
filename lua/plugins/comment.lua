return {
	"numToStr/Comment.nvim",
	event = { "BufEnter" },
	config = function()
		require("Comment").setup({
			toggler = {
				---Line-comment toggle keymap
				line = "<C-/>",
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
}
