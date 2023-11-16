return {
	{
		"ggandor/leap.nvim",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("leap").add_default_mappings(true)
		end,
	},
}
