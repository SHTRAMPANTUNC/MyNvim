return {
	{
		"nvim-tree/nvim-web-devicons",
		config = function()
			local mocha = require("catppuccin.palettes").get_palette("mocha")
			require("nvim-web-devicons").set_icon({
				cpp = {
					icon = "󰙲 ",
					color = mocha.lavender,
					name = "Cpp",
				},
				h = {
					icon = " ",
					color = mocha.mauve,
					name = "H",
				},
				hpp = {
					icon = " ",
					color = mocha.mauve,
					name = "Hpp",
				},
				c = {
					icon = "󰙱",
					color = mocha.sky,
					name = "C",
				},
				["cmakelists.txt"] = {
					icon = " ",
					color = mocha.sapphire,
					name = "CMakeLists",
				},
				["license.txt"] = {
					icon = " ",
					color = mocha.yellow,
					name = "LICENSE",
				},
				txt = {
					icon = " ",
					color = mocha.subtext1,
					name = "txt",
				},
				ninja = {
					icon = "󰝴 ",
					color = mocha.maroon,
					name = "ninja",
				},
				md = {
					icon = " ",
					color = mocha.sapphire,
					name = "exe",
				},
				out = {
					icon = "",
					color = mocha.red,
					name = "out",
				},
				sh = {
					icon = "",
					color = mocha.green,
					name = "Sy",
				},
				css = {
					icon = "",
					color = mocha.blue,
					name = "css",
				},
				["py"] = {
					icon = "",
					color = mocha.yellow,
					name = "Py",
				},
				["js"] = {
					icon = "",
					color = mocha.yellow,
					name = "Js",
				},
				["ts"] = {
					icon = "",
					color = mocha.blue,
					name = "Ts",
				},
				[".gitattributes"] = {
					icon = "",
					color = mocha.red,
					name = "GitAttributes",
				},
				[".gitignore"] = {
					icon = "",
					color = mocha.red,
					name = "GitIgnore",
				},
				["patch"] = {
					icon = "",
					color = mocha.red,
					name = "GitPatch",
				},
				["diff"] = {
					icon = "",
					color = "#e24329",
					name = "Diff",
				},
				["go"] = {
					icon = "",
					color = mocha.sapphire,
					name = "Go",
				},
				["lua"] = {
					icon = " ",
					color = mocha.sapphire,
					name = "Lua",
				},
			})
		end,
	},
}
