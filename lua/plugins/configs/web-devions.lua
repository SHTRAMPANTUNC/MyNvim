return {
	{
		"nvim-tree/nvim-web-devicons",
		config = function()
			require("nvim-web-devicons").set_icon({
				cpp = {
					icon = "󰙲 ",
					color = "#984c93",
					cterm_color = "65",
					name = "Cpp",
				},

				c = {
					icon = "󰙱",
					color = "#6396cd",
					cterm_color = "65",
					name = "C",
				},

				["cmakelists.txt"] = {
					icon = " ",
					color = "#51a0cf",
					cterm_color = "66",
					name = "CMakeLists",
				},

                ["conanfile.txt"] = {
                    icon = " ",
                    color = "#a6dafc",
					cterm_color = "66",
					name = "conanfile",
                },

				ninja = {
					icon = "󰝴 ",
					color = "#f1c27d",
					cterm_color = "66",
					name = "ninja",
				},

				exe = {
					icon = "",
					color = "#7d373a",
					cterm_color = "67",
					name = "exe",
				},

				out = {
					icon = "",
					color = "#7d373a",
					cterm_color = "67",
					name = "out",
				},

				sh = {
					icon = "",
					color = "#1DC123",
					cterm_color = "61",
					name = "Sy",
				},
                css = {
                    icon = "",
                    color = "#006ebc",
                    name = "css"
                },
				["py"] = {
					icon = "",
					color = "#519BB7",
					cterm_color = "59",
					name = "Py",
				},
				["js"] = {
					icon = "",
					color = "#cbcb41",
					cterm_color = "185",
					name = "Js",
				},
				["ts"] = {
					icon = "",
					color = "#519aba",
					cterm_color = "67",
					name = "Ts",
				},
				[".gitattributes"] = {
					icon = "",
					color = "#e24329",
					cterm_color = "59",
					name = "GitAttributes",
				},
				[".gitconfig"] = {
					icon = "",
					color = "#e24329",
					cterm_color = "59",
					name = "GitConfig",
				},
				[".gitignore"] = {
					icon = "",
					color = "#e24329",
					cterm_color = "59",
					name = "GitIgnore",
				},
				[".gitlab-ci.yml"] = {
					icon = "",
					color = "#e24329",
					cterm_color = "166",
					name = "GitlabCI",
				},
				[".gitmodules"] = {
					icon = "",
					color = "#e24329",
					cterm_color = "59",
					name = "GitModules",
				},
				["diff"] = {
					icon = "",
					color = "#e24329",
					cterm_color = "59",
					name = "Diff",
				},
				["go"] = {
					icon = " ",
					color = "#519aba",
					cterm_color = "74",
					name = "Go",
				},
		})
		end,
	},
}
