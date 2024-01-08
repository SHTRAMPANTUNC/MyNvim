return {
	{
		"tpope/vim-fugitive",
		event = { "User InGitRepo" },
	},

	{
		"ruifm/gitlinker.nvim",
		event = { "User InGitRepo" },
		config = function()
			require("gitlinker").setup({
				callbacks = {
					["dev.azure.com"] = function(url_data)
						vim.print(url_data)
						local url = require("gitlinker.hosts").get_base_https_url(url_data)

						if url_data.lstart then
							if url_data.lend == nil then
								url_data.lend = url_data.lstart
							end
							url = url
								.. "?path=/"
								.. url_data.file
								.. "&version=GC"
								.. url_data.rev
								.. "&line="
								.. url_data.lstart
								.. "&lineEnd="
								.. url_data.lend
								.. "&lineStartColumn=1"
								.. "&lineEndColumn=120"
						end
						return url
					end,
				},
				mappings = nil,
			})
		end,
	},

	{
		"rbong/vim-flog",
		cmd = "Flog",
	},

	{
		"sindrets/diffview.nvim",
		cmd = "DiffviewOpen",
	},
}
