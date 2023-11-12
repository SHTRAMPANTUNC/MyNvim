return {
	{
		"goolord/alpha-nvim",
		enabled = true,
		event = "VimEnter",
		config = function()
			local present, alpha = pcall(require, "alpha")
			if not present then
				return "Alpha has an error"
			end

			local header = {
				type = "text",
				val = {
					"",
					"",
					"",
					"",
					"",
					"",
					"",
					"",
					"                                                  ",
					[[                                                                     ]],
					[[       ████ ██████           █████      ██                     ]],
					[[      ███████████             █████                             ]],
					[[      █████████ ███████████████████ ███   ███████████   ]],
					[[     █████████  ███    █████████████ █████ ██████████████   ]],
					[[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
					[[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
					[[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
					[[                                                                       ]],
					[[                                                                       ]],
				},
				opts = {
					position = "center",
					hl = "Function",
				},
			}

			local function button(sc, txt, keybind)
				local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")
				local opts = {
					position = "center",
					text = txt,
					shortcut = sc,
					cursor = 3,
					width = 40,
					align_shortcut = "right",
					hl_shortcut = "Number",
					hl = "Function",
				}
				if keybind then
					opts.keymap = { "n", sc_, keybind, { noremap = true, silent = true } }
				end
				return {
					type = "button",
					val = txt,
					on_press = function()
						local key = vim.api.nvim_replace_termcodes(sc_, true, false, true)
						vim.api.nvim_feedkeys(key, "normal", false)
					end,
					opts = opts,
				}
			end

			local buttons = {
				type = "group",
				val = {
					button("e", "  > New file", ":ene <BAR> startinsert <CR>"),
					button("r", "  > Projects", ":Telescope projects<CR>"),
					button("f", "  > Find file", ":cd $HOME/ | Telescope find_files<CR>"),
					-- button("u", "  > Update plugins", "<cmd>Lazy sync<CR>"),
					button("c", "  > Settings", ":e $MYVIMRC | :cd %:p:h | wincmd k | :NvimTreeOpen<CR>"),
					button("q", "󰩈  > Quit NVIM", ":qa<CR>"),
				},
				opts = {
					position = "center",
					spacing = 1,
				},
			}

			local function pluginstats()
				local stats = require("lazy").stats()
				local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
				return " " .. stats.count .. " plugins"
			end

			local function stats()
				-- Number of plugins
				local plugins_text = " v"
					.. vim.version().major
					.. "."
					.. vim.version().minor
					.. "."
					.. vim.version().patch
					.. "   |   "
				return plugins_text .. pluginstats() .. "\n"
			end

			local function footer()
				local stats = require("lazy").stats()
				local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
				return "🍺 Late to drink Borjomi"
			end

			local Stats = {
				type = "text",
				val = stats,
				opts = {
					position = "center",
					hl = "Function",
				},
			}

			local Plugstats = {
				type = "text",
				val = footer,
				opts = {
					position = "center",
					hl = "Function",
				},
			}

			local section = {
				header = header,
				buttons = buttons,
				footer = Stats,
				stats = Plugstats,
			}

			local opts = {
				layout = {
					{ type = "padding", val = 1 },
					section.header,
					{ type = "padding", val = 1 },
					section.footer,
					{ type = "padding", val = 2 },
					section.buttons,
					{ type = "padding", val = 1 },
					section.stats,
				},
				opts = {
					margin = 44,
				},
			}

			alpha.setup(opts)
		end,
	},
}
