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

			local path_ok, plenary_path = pcall(require, "plenary.path")
			if not path_ok then
				return
			end

			local dashboard = require("alpha.themes.dashboard")
			local cdir = vim.fn.getcwd()
			local if_nil = vim.F.if_nil

			local nvim_web_devicons = {
				enabled = true,
				highlight = true,
			}

			local function get_extension(fn)
				local match = fn:match("^.+(%..+)$")
				local ext = ""
				if match ~= nil then
					ext = match:sub(2)
				end
				return ext
			end

			local function icon(fn)
				local nwd = require("nvim-web-devicons")
				local ext = get_extension(fn)
				return nwd.get_icon(fn, ext, { default = true })
			end

			local function file_button(fn, sc, short_fn, autocd)
				short_fn = short_fn or fn
				local ico_txt
				local fb_hl = {}

				if nvim_web_devicons.enabled then
					local ico, hl = icon(fn)
					local hl_option_type = type(nvim_web_devicons.highlight)
					if hl_option_type == "boolean" then
						if hl and nvim_web_devicons.highlight then
							table.insert(fb_hl, { hl, 0, #ico })
						end
					end
					if hl_option_type == "string" then
						table.insert(fb_hl, { nvim_web_devicons.highlight, 0, #ico })
					end
					ico_txt = ico .. "  "
				else
					ico_txt = ""
				end
				local cd_cmd = (autocd and " | cd %:p:h" or "")
				local file_button_el =
					dashboard.button(sc, ico_txt .. short_fn, "<cmd>e " .. vim.fn.fnameescape(fn) .. cd_cmd .. " <CR>")
				local fn_start = short_fn:match(".*[/\\]")
				if fn_start ~= nil then
					table.insert(fb_hl, { "Comment", #ico_txt - 2, #fn_start + #ico_txt })
				end
				file_button_el.opts.hl = fb_hl
				return file_button_el
			end

			local default_mru_ignore = { "gitcommit" }

			local mru_opts = {
				ignore = function(path, ext)
					return (string.find(path, "COMMIT_EDITMSG")) or (vim.tbl_contains(default_mru_ignore, ext))
				end,
				autocd = false,
			}

			--- @param start number
			--- @param cwd string? optional
			--- @param items_number number? optional number of items to generate, default = 10
			local function mru(start, cwd, items_number, opts)
				opts = opts or mru_opts
				items_number = if_nil(items_number, 10)

				local oldfiles = {}
				for _, v in pairs(vim.v.oldfiles) do
					if #oldfiles == items_number then
						break
					end
					local cwd_cond
					if not cwd then
						cwd_cond = true
					else
						cwd_cond = vim.startswith(v, cwd)
					end
					local ignore = (opts.ignore and opts.ignore(v, get_extension(v))) or false
					if (vim.fn.filereadable(v) == 1) and cwd_cond and not ignore then
						oldfiles[#oldfiles + 1] = v
					end
				end
				local target_width = 35

				local tbl = {}
				for i, fn in ipairs(oldfiles) do
					local short_fn
					if cwd then
						short_fn = vim.fn.fnamemodify(fn, ":.")
					else
						short_fn = vim.fn.fnamemodify(fn, ":~")
					end

					if #short_fn > target_width then
						short_fn = plenary_path.new(short_fn):shorten(1, { -2, -1 })
						if #short_fn > target_width then
							short_fn = plenary_path.new(short_fn):shorten(1, { -1 })
						end
					end

					local shortcut = tostring(i + start - 1)

					local file_button_el = file_button(fn, shortcut, short_fn, opts.autocd)
					tbl[i] = file_button_el
				end
				return {
					type = "group",
					val = tbl,
					opts = {},
				}
			end

			local header = {
				type = "text",
				val = {
					"",
					"",
					"",
					"",
					"",
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

			local section_mru = {
				type = "group",
				val = {
					{
						type = "text",
						val = "Recent files",
						opts = {
							hl = "SpecialComment",
							shrink_margin = false,
							position = "center",
						},
					},
					{ type = "padding", val = 1 },
					{
						type = "group",
						val = function()
							return { mru(0, cdir) }
						end,
						opts = { shrink_margin = false },
					},
				},
			}

			local function pluginstats()
				local stats = require("lazy").stats()
				local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
				return "  " .. stats.count .. " plugins"
			end

			local function stats()
				-- Number of plugins
				local plugins_text = " v"
					.. vim.version().major
					.. "."
					.. vim.version().minor
					.. "."
					.. vim.version().patch
					.. "  |  "
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
				footer = Stats,
				stats = Plugstats,
				section_mru = section_mru,
			}

			local opts = {
				layout = {
					{ type = "padding", val = 0 },
					section.header,
					{ type = "padding", val = 0 },
					section.footer,
					{ type = "padding", val = 1 },
					section.section_mru,
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
