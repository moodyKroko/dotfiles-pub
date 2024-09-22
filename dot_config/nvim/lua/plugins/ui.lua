return {
	-- disabled UI packages
	{ "indent-blankline.nvim", enabled = false },
	{ "akinsho/bufferline.nvim", enabled = false },
	{
		"echasnovski/mini.indentscope",
		enabled = false,
	},

	{
		"folke/noice.nvim",
		opts = {
			cmdline = {
				view = "cmdline",
			},

			views = {
				popupmenu = {
					relative = "editor",
					position = {
						row = "97%",
						col = "2%",
					},
					border = {
						style = "rounded",
					},
				},
			},

			presets = {
				command_palette = false,
				lsp_doc_border = true,
			},
		},
	},

	-- status line
	{
		"nvim-lualine/lualine.nvim",
		-- enabled = false,
		opts = {
			options = {
				theme = "papercolor_light",
			},
			sections = {
				lualine_c = {
					{
						"diagnostics",
						symbols = {
							error = " ",
							warn = "󰀪 ",
							info = "󰌶 ",
							hint = " ",
						},
					},
					{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
					{ LazyVim.lualine.pretty_path() },
				},
			},
		},
	},

	-- rainbow brackets
	{
		"hiphish/rainbow-delimiters.nvim",
		event = "BufReadPre",
	},

	-- mason signs
	{
		"williamboman/mason.nvim",
		opts = {
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
				border = "rounded",
			},
		},
	},

	{
		"LazyVim/LazyVim",
		opts = {
			icons = {
				diagnostics = {
					Error = " ",
				},
			},
		},
	},

	{
		"nvim-lspconfig",
		opts = {
			diagnostics = {
				virtual_text = true,
				update_in_insert = false,
				float = {
					focusable = false,
					style = "minimal",
					border = "rounded",
					source = "always",
					header = "",
					prefix = "",
				},
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = " ",
						[vim.diagnostic.severity.WARN] = "󰀪 ",
						[vim.diagnostic.severity.HINT] = "󰌶 ",
						[vim.diagnostic.severity.INFO] = " ",
					},
				},
			},
		},
	},

	{
		"nvimdev/dashboard-nvim",
		opts = function(_, opts)
			local logo = [[
███╗   ███╗ ██████╗  ██████╗ ██████╗ ██╗   ██╗██╗  ██╗██████╗  ██████╗ ██╗  ██╗ ██████╗ 
████╗ ████║██╔═══██╗██╔═══██╗██╔══██╗╚██╗ ██╔╝██║ ██╔╝██╔══██╗██╔═══██╗██║ ██╔╝██╔═══██╗
██╔████╔██║██║   ██║██║   ██║██║  ██║ ╚████╔╝ █████╔╝ ██████╔╝██║   ██║█████╔╝ ██║   ██║
██║╚██╔╝██║██║   ██║██║   ██║██║  ██║  ╚██╔╝  ██╔═██╗ ██╔══██╗██║   ██║██╔═██╗ ██║   ██║
██║ ╚═╝ ██║╚██████╔╝╚██████╔╝██████╔╝   ██║   ██║  ██╗██║  ██║╚██████╔╝██║  ██╗╚██████╔╝
╚═╝     ╚═╝ ╚═════╝  ╚═════╝ ╚═════╝    ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝ ╚═════╝ 
                                                                                        
      ]]
			logo = string.rep("\n", 8) .. logo .. "\n\n"
			opts.config.header = vim.split(logo, "\n")
		end,
	},
}
