return {
	{
		"jose-elias-alvarez/null-ls.nvim",
		event = "BufRead",
		config = function()
			local status, null_ls = pcall(require, "null-ls")
			if not status then
				return
			end

			local formatting = null_ls.builtins.formatting
			local diagnostics = null_ls.builtins.diagnostics
			local code_actions = null_ls.builtins.code_actions

			local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

			null_ls.setup({
				sources = {
					formatting.clang_format,
					formatting.stylua,
                    diagnostics.tidy
				},
				on_attach = function(client, bufnr)
					if client.supports_method("textDocument/formatting") then
						vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					end
				end,
			})

			vim.api.nvim_create_user_command("DisableLspFormatting", function()
				vim.api.nvim_clear_autocmds({ group = augroup, buffer = 0 })
			end, { nargs = 0 })
		end,
	},
}
