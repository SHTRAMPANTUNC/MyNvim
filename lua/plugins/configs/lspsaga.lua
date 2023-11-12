return {
	{
		"nvimdev/lspsaga.nvim",
		event = "LspAttach",
		config = function()
			local status, saga = pcall(require, "lspsaga")
			if not status then
				return
			end

			saga.setup({
				ui = {
					border = "rounded",
					code_action = "🤯",
					sign = true,
				},
				symbol_in_winbar = {
					enable = false,
				},
				lightbulb = {
					enable = true,
				},
				outline = {
					layout = "float",
				},
				diagnostic = {
					on_insert = false,
					on_insert_follow = false,
				},
			})
		end,
	},
}
