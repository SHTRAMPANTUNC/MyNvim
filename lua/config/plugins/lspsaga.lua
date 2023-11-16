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
					enable_in_insert = false,
				},
				outline = {
					layout = "floar",
				},
				diagnostic = {
					on_insert = false,
					on_insert_follow = false,
				},
				code_bction = {
					num_shortcut = true,
					show_server_name = false,
					extend_gitsigns = true,
				},
			})
		end,
	},
}
