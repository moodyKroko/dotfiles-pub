-- current color scheme
return {
	{
		"cpea2506/one_monokai.nvim",
		lazy = false,
    enabled = false,
		priority = 1000,
		opts = function()
			return {
				transparent = true,

				-- https://coolors.co/f6c173-703aa6-6d58a7-6ba292-acadbc
				themes = function(colors)
					return {
						border = { fg = colors.purple, bg = colors.none },
						FloatBorder = { fg = colors.purple, bg = colors.none },

						LineNr = { fg = colors.fg:darken(0.5) },
						ColorColumn = { bg = colors.purple:darken(0.3) },
						CursorLine = { bg = colors.none },
						CursorLineNr = { fg = colors.fg },
						Search = { fg = colors.black, bg = colors.red },

						CmpPmenu = { bg = colors.none },
						CmpSel = { fg = colors.white, bg = colors.fg:darken(0.5) },
						CmpDoc = { bg = colors.none },

						NoiceCmdlinePopupBorder = { fg = colors.purple, bg = colors.none },
						DashboardHeader = { fg = colors.aqua },
						NotifyBackground = { bg = colors.white },
					}
				end,
			}
		end,
	},

	{
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function ()
      return {
        require("kanagawa").setup({
          transparent = true,
          functionStyle = { bold = true },
        })
      }
    end
  },

	{
		"LazyVim/LazyVim",
		opts = {
      -- colorscheme = "one_monokai",
      colorscheme = "kanagawa",
		},
	},
}
