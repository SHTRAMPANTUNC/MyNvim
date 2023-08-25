local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
	},

	{
		"phaazon/hop.nvim",
	},

  {
  'nvimdev/hlsearch.nvim',
   event = 'BufRead',
   config = function()
      require('hlsearch').setup()
   end
  },

	{
		"rebelot/kanagawa.nvim",
		lazy = true,
		priority = 1000,
		build = ":KanagawaCompile",
	},

	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		enable = true,
		event = "VimEnter",
	},

	{
		"jiangmiao/auto-pairs",
	},

	--Telescope
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.2",
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
	},

	{
		"glepnir/dashboard-nvim",
		event = "VimEnter",
		dependencies = { { "nvim-tree/nvim-web-devicons" } },
	},

	--AutoCmpPlugins

	{ "neovim/nvim-lspconfig" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{ "hrsh7th/cmp-cmdline" },

	{
		"hrsh7th/nvim-cmp",
		enabled = true,
		event = "InsertEnter",
	},

	{ "saadparwaiz1/cmp_luasnip" },
	{ "rafamadriz/friendly-snippets" },

	{
		"L3MON4D3/LuaSnip",
		dependencies = { "rafamadriz/friendly-snippets" },
	},

	{
		"numToStr/Comment.nvim",
		enable = true,
		event = "VeryLazy",
	},

	{
		"lewis6991/gitsigns.nvim",
	},

	{
		"cdelledonne/vim-cmake",
		event = LspAttach,
		ft = { "c", "cpp" },
	},

  {
    'windwp/nvim-ts-autotag',
    config = function()
      require("nvim-ts-autotag").setup()
    end,
    event = LspAttach,
    ft = { "typescript", "typescriptreact", "typescript.tsx" }
  },

	{
		"nvim-lualine/lualine.nvim",
	},



	--LSP
	{
		"nvimdev/lspsaga.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
	},

	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
	},

	{
		"jose-elias-alvarez/null-ls.nvim",
	},

	{
		"neovim/nvim-lspconfig",
	},

	{
		"onsails/lspkind.nvim",
	},




	{
		"nvim-treesitter/nvim-treesitter",
		enable = true,
		event = "BufReadPre",
	},

	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = true,
		enable = true,
		event = "VeryLazy",
	},

	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	{
		"dinhhuy258/git.nvim",
	},
})

--(┬┬﹏┬┬)
