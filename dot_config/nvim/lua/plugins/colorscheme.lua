return {
  -- current color scheme
  {
    "cpea2506/one_monokai.nvim",
    lazy = false,
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
          }
        end,
      }
    end,
  },

  -- {
  --   "rose-pine/neovim",
  --   lazy = false,
  --   enabled = false,
  --   name = "rose-pine",
  --   priority = 1000,
  --   config = function()
  --     return {
  --       require("rose-pine").setup({
  --         variant = "auto",
  --         dark_variant = "moon",
  --         dim_inactive_windows = false,
  --         extend_background_behind_borders = false,
  --
  --         styles = {
  --           transparency = true,
  --         },
  --
  --         groups = {
  --           border = "#f6c173", --"pine",
  --           -- background = "none",
  --           -- TODO: make the green foreground color a lil darker
  --         },
  --
  --         highlight_groups = {
  --           ColorColumn = { bg = "highlight_low", blend = 40 },
  --           -- CursorLine = { bg = "none", blend = 90 },
  --           CursorLine = { bg = "none" },
  --
  --           Search = { bg = "love", inherit = false },
  --           FloatBorder = { fg = "#f6c173", bg = "none" },
  --           LineNr = { fg = "#f6c173" }, -- gold
  --
  --           -- nvim-cmp
  --           CmpPmenu = { bg = "none" }, --{ bg = "#011b26" },
  --           CmpSel = { bg = "highlight_high" },
  --           CmpDoc = { bg = "none" }, -- { bg = "#011b26" },
  --
  --           -- Telescope
  --           TelescopeBorder = { fg = "#f6c173", bg = "none" },
  --           TelescopeNormal = { bg = "none" },
  --           TelescopePromptNormal = { bg = "none" },
  --           TelescopeResultsNormal = { fg = "subtle", bg = "none" },
  --           TelescopeSelection = { fg = "text", bg = "pine", blend = 40 },
  --           TelescopeSelectionCaret = { fg = "rose", bg = "none" },
  --         },
  --       }),
  --
  --       vim.cmd("colorscheme rose-pine"),
  --     }
  --   end,
  -- },
}
