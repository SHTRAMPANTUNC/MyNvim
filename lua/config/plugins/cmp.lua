return {
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			{
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-cmdline",
				"saadparwaiz1/cmp_luasnip",
				"rafamadriz/friendly-snippets",
				"L3MON4D3/LuaSnip",
				"hrsh7th/cmp-nvim-lsp",
				"onsails/lspkind.nvim",
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
					Method = " ",
					Function = " ",
					Constructor = " ",
					Field = " ",
					Variable = " ",
					Class = " ",
					Interface = " ",
					Module = " ",
					Property = " ",
					Unit = " ",
					Value = "󰾡 ",
					Enum = " ",
					Keyword = " ",
					Snippet = " ",
					Color = " ",
					File = " ",
					Reference = " ",
					Folder = " ",
					EnumMember = " ",
					Constant = " ",
					Struct = " ",
					Event = " ",
					Operator = " ",
					TypeParameter = " ",
					Specifier = " ",
					Statement = "",
					Recovery = " ",
					TranslationUnit = " ",
				},
			})

			require("luasnip.loaders.from_vscode").lazy_load()
			cmp.setup({
				preselect = "None",
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},

				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},

				mapping = cmp.mapping.preset.insert({
					["<C-k>"] = cmp.mapping.select_prev_item(),
					["<C-j>"] = cmp.mapping.select_next_item(),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
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
					{ name = "luasnip", max_item_count = 5, group_index = 1 },
					{ name = "nvim_lsp", max_item_count = 20, group_index = 1 },
					{ name = "path", group_index = 2 },
					{ name = "buffer", keyword_length = 2, max_item_count = 5, group_index = 2 },
				}),

				formatting = {
					format = lspkind.cmp_format({
						maxwidth = 50,
					}),
				},
			})

			experimental = {
				ghost_text = false,
			}
		end,
	},
}
