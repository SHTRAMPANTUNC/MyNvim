return {
	{
		"nvim-lualine/lualine.nvim",
		enable = true,
		event = "VeryLazy",
		config = function()
			local lualine = require("lualine")

			local colors = {
				bg = "#202328",
				fg = "#bbc2cf",
				yellow = "#ECBE7B",
				cyan = "#538EA8",
				darkblue = "#081633",
				green = "#98be65",
				orange = "#FF8800",
				violet = "#917bb3",
				magenta = "#c678dd",
				blue = "#748fc7",
				red = "#ec5f67",
				white = "#a8afbc",
			}

			local conditions = {
				buffer_not_empty = function()
					return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
				end,
				hide_in_width = function()
					return vim.fn.winwidth(0) > 80
				end,
				check_git_workspace = function()
					local filepath = vim.fn.expand("%:p:h")
					local gitdir = vim.fn.finddir(".git", filepath .. ";")
					return gitdir and #gitdir > 0 and #gitdir < #filepath
				end,
			}

			-- Config
			local config = {
				options = {
					component_separators = "",
					section_separators = "",
					theme = {
						normal = { c = { fg = colors.fg, bg = colors.bg } },
						inactive = { c = { fg = colors.fg, bg = colors.bg } },
					},
				},
				sections = {
					-- these are to remove the defaults
					lualine_a = {},
					lualine_b = {},
					lualine_y = {},
					lualine_z = {},
					-- These will be filled later
					lualine_c = {},
					lualine_x = {},
				},
				inactive_sections = {
					-- these are to remove the defaults
					lualine_a = {},
					lualine_b = {},
					lualine_y = {},
					lualine_z = {},
					lualine_c = {},
					lualine_x = {},
				},
			}

			local function ins_left(component)
				table.insert(config.sections.lualine_c, component)
			end

			local function ins_right(component)
				table.insert(config.sections.lualine_x, component)
			end

			local mode_color = {
				n = colors.blue,
				i = colors.green,
				v = colors.cyan,
				[""] = colors.cyan,
				V = colors.blue,
				c = colors.yellow,
				no = colors.red,
				s = colors.orange,
				S = colors.orange,
				[""] = colors.orange,
				ic = colors.yellow,
				R = colors.violet,
				Rv = colors.violet,
				cv = colors.red,
				ce = colors.red,
				r = colors.cyan,
				rm = colors.cyan,
				["r?"] = colors.cyan,
				["!"] = colors.red,
				t = colors.red,
			}

			ins_left({
				-- mode component
				function()
					local mode_icon = {
						n = "NORMAL",
						i = "INSERT",
						v = "VISUAL",
						c = "COMMAND",
						t = "TERMINAL",
						[""] = "V-BLOCK",
					}
					return mode_icon[vim.fn.mode()]
				end,
				color = function()
					return { gui = "bold", bg = mode_color[vim.fn.mode()], fg = "#1f2228" }
				end,
				padding = { right = 2, left = 2 },
			})

			ins_left({
				"branch",
				icon = "",
				color = function()
					return { bg = "#393947", fg = mode_color[vim.fn.mode()], gui = "bold" }
				end,
				padding = { right = 1, left = 1 },
			})

			ins_left({
				"diff",
				symbols = { added = " ", modified = "󱓻 ", removed = " " },
				color = function()
					return { bg = "#393947", gui = "bold" }
				end,
				cond = conditions.hide_in_width,
			})

			ins_left ({
				function()
					local icon
					local ok, devicons = pcall(require, "nvim-web-devicons")
					if ok then
						icon = devicons.get_icon(vim.fn.expand("%:t"))
						if icon == nil then
							icon = devicons.get_icon_by_filetype(vim.bo.filetype)
						end
					else
						if vim.fn.exists("*WebDevIconsGetFileTypeSymbol") > 0 then
							icon = vim.fn.WebDevIconsGetFileTypeSymbol()
						end
					end
					return icon:gsub("%s+", "")
				end,
				color = function()
					return { fg = colors.white }
				end,
			})

			ins_left({
				"filename",
				cond = conditions.buffer_not_empty,
				color = { fg = colors.white, gui = "bold" },
				padding = { right = 1, left = 1 },
			})

			ins_right({
				"diagnostics",
				sources = { "nvim_diagnostic" },
				symbols = { error = "󰅚 ", warn = " ", info = " " },
				diagnostics_color = {
					color_error = { fg = colors.red },
					color_warn = { fg = colors.yellow },
					color_info = { fg = colors.cyan },
				},
			})

			ins_right({
				-- Lsp server name .
				function()
					local msg = "No Active Lsp"
					local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
					local clients = vim.lsp.get_active_clients()
					if next(clients) == nil then
						return msg
					end
					for _, client in ipairs(clients) do
						local filetypes = client.config.filetypes
						if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
							return client.name
						end
					end
					return msg
				end,
				icon = "  LSP ~",
				color = { fg = colors.white, gui = "bold" },
			})

			-- Add components to right sections
			ins_right({
				"o:encoding",
				fmt = string.upper,
				cond = conditions.hide_in_width,
				color = { fg = colors.green, gui = "bold" },
			})

			ins_right({
				"fileformat",
				fmt = string.upper,
				icons_enabled = false,
				color = { fg = colors.green, gui = "bold" },
			})

			ins_right({
				"progress",
				color = function()
					return { bg = mode_color[vim.fn.mode()], fg = "#1f2228", gui = "bold" }
				end,
				padding = { left = 2, right = 2 },
			})

			lualine.setup(config)
		end,
	},
}
