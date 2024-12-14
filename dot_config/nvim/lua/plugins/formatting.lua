return {
	{
		"stevearc/conform.nvim",
		opts = function(_, opts)
			opts.formatters_by_ft = {
				astro = { "prettier" },
				javascript = { "prettier" },
				javascriptreact = { "prettier" },
				typescript = { "prettier" },
				typescriptreact = { "prettier" },
				vue = { "prettier" },
				css = { "prettier" },
				scss = { "prettier" },
				less = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				jsonc = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				graphql = { "prettier" },
				handlebars = { "prettier" },
				-- go = { "goimports", "gofmt" },
			}

			opts.formatters = opts.formatters or {}
			opts.formatters.prettier = {
				filetypes = { "astro" },
				prepend_args = { "--plugin", "prettier-plugin-astro", "--plugin", "prettier-plugin-tailwindcss" },
			}
		end,
	},
}
