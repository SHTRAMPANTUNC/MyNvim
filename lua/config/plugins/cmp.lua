return {
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			{
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-cmdline",
				"hrsh7th/cmp-nvim-lsp",
				"onsails/lspkind.nvim",
				"saadparwaiz1/cmp_luasnip",
				"rafamadriz/friendly-snippets",
				{
					"L3MON4D3/LuaSnip",
					config = function()
						require("luasnip.loaders.from_vscode").lazy_load()
						vim.api.nvim_create_autocmd("InsertLeave", {
							callback = function()
								if
									require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
									and not require("luasnip").session.jump_active
								then
									require("luasnip").unlink_current()
								end
							end,
						})
					end,
				},
			},
		},
		config = function()
			local cmp = require("cmp")
			local lspkind = require("lspkind")
			local status, lspkind = pcall(require, "lspkind")
			if not status then
				return
			end

			lspkind.init({

				symbol_map = {
					Text = "󰦨 ",
					Method = " ",
					Function = " ",
					Constructor = " ",
					Field = " ",
					Variable = " ",
					Class = " ",
					Interface = " ",
					Module = " ",
					Property = " ",
					Unit = " ",
					Value = "󰾡 ",
					Enum = " ",
					Keyword = "  ",
					Snippet = " ",
					Color = " ",
					File = " ",
					Reference = " ",
					Folder = " ",
					EnumMember = " ",
					Constant = " ",
					Struct = "  ",
					Event = " ",
					Operator = " ",
					TypeParameter = " ",
					Specifier = " ",
					Statement = " ",
					Recovery = " ",
					TranslationUnit = " ",
				},
			})

			cmp.setup({
				preselect = "None",
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},

				window = {
					completion = {
						winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:None",
						scrollbar = false,
					},
					documentation = cmp.config.disable,
				},

				mapping = cmp.mapping.preset.insert({
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = "luasnip", group_index = 1 },
					{
						name = "nvim_lsp",
						max_item_count = 35,
						group_index = 1,
						entry_filter = function(entry)
							return require("cmp.types").lsp.CompletionItemKind[entry:get_kind()] ~= "Text"
						end,
					},
					{
						name = "path",
						group_index = 2,
						trigger_characters = { "/", "./", "../" },
					},
					{
						name = "buffer",
						option = {
							get_bufnrs = function()
								return vim.api.nvim_list_bufs()
							end,
						},
						keyword_length = 2,
						max_item_count = 5,
						group_index = 2,
					},
				}),
				completion = {
					keyword_length = 1,
					completeopt = "menu,menuone,noinsert",
				},

				view = {
					entries = "custom",
				},

				formatting = {
					fields = {
						"abbr",
						"kind",
					},
					format = lspkind.cmp_format({
						maxwidth = 50,
						mode = "symbol_text",
					}),
				},
				experimental = {
					ghost_text = false,
				},
			})
		end,
	},
}
