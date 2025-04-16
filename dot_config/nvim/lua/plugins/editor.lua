return {
	{ "folke/flash.nvim", enabled = false },
	{ "folke/persistence.nvim", enabled = false },
	{ "nvim-neo-tree/neo-tree.nvim", enabled = false },

	-- treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = {
				"css",
				"gitignore",
				"go",
				"http",
				"java",
				"sql",
			},
		},
	},

	-- dap (debuggings)
	{
		"mfussenegger/nvim-dap",
		ft = { "go", "python" }, -- Load only for Go and Python files
		dependencies = {
			"rcarriga/nvim-dap-ui",
			-- virtual text for the debugger
			{
				"theHamsta/nvim-dap-virtual-text",
				opts = {},
			},
		},
	},
	{
		"leoluz/nvim-dap-go",
		ft = "go", -- Load only for Go files
		dependencies = "mfussenegger/nvim-dap",
		config = function()
			require("dap-go").setup()
		end,
	},
	{
		"mfussenegger/nvim-dap-python",
		ft = "python", -- Load only for Python files
		dependencies = "mfussenegger/nvim-dap",
		config = function()
			require("dap-python").setup("python")
		end,
	},

	-- auto sessions
	{
		"rmagatti/auto-session",
		lazy = false,
		config = function()
			require("auto-session").setup({
				log_level = vim.log.levels.ERROR,

				auto_session_enabled = true,
				-- auto_save_enabled = true,
				-- auto_restore_enabled = true,

				-- "C:\\", "C:\\Users\\james"
				auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/", "$HOME" },
				auto_session_use_git_branch = false,

				bypass_save_filetypes = { "alpha", "dashboard" },

				cwd_change_handling = true,

				pre_cwd_changed_cmds = {
					"tabdo NERDTreeClose",
				},
			})
		end,
		keys = {
			{
				"<leader>fs",
				"<cmd>SessionSearch<CR>",
				desc = "Search for a session",
			},
			{
				"<leader>fsv",
				"<cmd>SessionSave<CR>",
				desc = "Save session",
			},
		},
	},

	-- trouble
	{
		"folke/trouble.nvim",
		opts = {
			modes = {
				lsp = {
					win = { position = "bottom" },
				},
			},
		},
	},

	{
		"which-key.nvim",
		opts = {
			preset = "classic",
			spec = {
				["<leader>dv"] = { name = "+diffview" },
			},
		},
	},

	{
		"sindrets/diffview.nvim",
		dependencies = {
			{ "nvim-tree/nvim-web-devicons", lazy = true },
		},

		keys = {
			{
				"dv",
				function()
					if next(require("diffview.lib").views) == nil then
						vim.cmd("DiffviewOpen")
					else
						vim.cmd("DiffviewClose")
					end
				end,
				desc = "Toggle Diffview window",
			},
		},
	},
}
