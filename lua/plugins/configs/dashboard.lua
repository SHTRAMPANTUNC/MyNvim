local api = vim.api

local keymap = vim.keymap
require("dashboard").setup({
	theme = "hyper",
	config = {
		header = {
			[[                                                                                         ]],
			[[                                                                                         ]],
			[[                                                                                         ]],
			[[                  ,--.                ,----..                                    ____    ]],
			[[                ,--.'|     ,---,.    /   /   \                   ,---,         ,'  , `.  ]],
			[[            ,--,:  : |   ,'  .' |   /   .     :         ,---. ,`--.' |      ,-+-,.' _ |  ]],
			[[         ,`--.'`|  ' : ,---.'   |  .   /   ;.  \       /__./| |   :  :   ,-+-. ;   , ||  ]],
			[[         |   :  :  | | |   |   .' .   ;   /  ` ;  ,---.;  ; | :   |  '  ,--.'|'   |  ;|  ]],
			[[         :   |   \ | : :   :  |-, ;   |  ; \ ; | /___/ \  | | |   :  | |   |  ,', |  ':  ]],
			[[         |   : '  '; | :   |  ;/| |   :  | ; | ' \   ;  \ ' | '   '  ; |   | /  | |  ||  ]],
			[[         '   ' ;.    ; |   :   .' .   |  ' ' ' :  \   \  \: | |   |  | '   | :  | :  |,  ]],
			[[         |   | | \   | |   |  |-, '   ;  \; /  |   ;   \  ' . '   :  ; ;   . |  ; |--'   ]],
			[[         '   : |  ; .' '   :  ;/|  \   \  ',  /     \   \   ' |   |  ' |   : |  | ,      ]],
			[[         |   | '`--'   |   |    \   ;   :    /       \   `  ; '   :  | |   : '  |/       ]],
			[[         '   : |       |   :   .'    \   \ .'         :   \ | ;   |.'  ;   | |`-'        ]],
			[[         ;   |.'       |   | ,'       `---`            '---"  '---'    |   ;/            ]],
			[[         '---'         `----'                                          '---'             ]],
			[[                                                                                         ]],
			[[                                                                                         ]],
			[[                                                                                         ]],
		},
		shortcut = {
			{ desc = "  Plugins", group = "@property", action = "Lazy", key = "l" },
			{
				icon = "  ",
				icon_hl = "@variable",
				desc = "Files",
				group = "Label",
				action = "Telescope find_files",
				key = "f",
			},
			{
				desc = "󰩈 Exit",
				group = "DiagnosticHint",
				action = ":q!",
				key = "q",
			},
			{
				desc = " dotfiles",
				group = "Number",
				action = "tabnew $MYVIMRC | tcd %:p:h",
				key = "d",
			},
		},

		footer = {
			"",
			" 🍺 Late to drink Borjomi",
		},
	},
})

api.nvim_create_autocmd("FileType", {
	pattern = "dashboard",
	group = api.nvim_create_augroup("dashboard_enter", { clear = true }),
	callback = function()
		keymap.set("n", "q", ":qa<CR>", { buffer = true, silent = true })
		keymap.set("n", "e", ":enew<CR>", { buffer = true, silent = true })
	end,
})
