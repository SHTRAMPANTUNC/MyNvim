local M = {}

M.PREF = {
	common = {
		textwidth = 130,
		tabwidth = 4,
	},
}

M.lsp = {
	diagnostic = {
		underline = false,
		signs = true,
		virtual_text = false,
		severity_sort = true,
	},
	install_servers = {
		"clangd",
		"cmake",
		"lua_ls",
		"jsonls",
		"dockerls",
		"ltex",
        "gopls"
	},
}

local signs = {
	Error = "🤮",
	Warn = "🤢",
	Hint = "🤯",
	Info = "🤔",
}

for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

return M
