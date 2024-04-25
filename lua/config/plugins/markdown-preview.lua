return {
	{
		"iamcco/markdown-preview.nvim",
		enabled = PREF.plugins.markdown_preview,
		build = "cd app && npm install",
		ft = { "markdown" },
		config = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
	},
}
