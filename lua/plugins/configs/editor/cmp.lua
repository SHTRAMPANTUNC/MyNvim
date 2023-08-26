local cmp = require("cmp")
local lspkind = require("lspkind")
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
	mapping = cmp.mapping.preset.insert({
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
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},

	formatting = {
		format = lspkind.cmp_format({
			with_text = false,
			maxwidth = 50,
			menu = {
				buffer = "[BUF]",
				nvim_lsp = "[LSP]",
				luasnip = "[SNP]",
				nvim_lua = "[LUA]",
				latex_symbols = "[SYM]",
			},
		}),
	},

  experimental = {
    ghost_text = false,
  },
	sources = cmp.config.sources({
		{ name = "nvim_lsp_signature_help" },
		{ name = "nvim_lsp", priority = 9, max_item_count = 10 },
		{ name = "luasnip", keyword_lenght = 3, priority = 8, max_item_count = 10 },
	}, {
		{ name = "buffer", priority = 7 },
		{ name = "path", priority = 6 },
		{ name = "friend", priority = 5 },
		{ name = "nvim_lua", priority = 4 },
	}),
})
