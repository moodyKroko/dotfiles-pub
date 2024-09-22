-- Set border of some LazyVim plugins to rounded
local BORDER_STYLE = "rounded"

return {
  -- completion border
  {
    "nvim-cmp",
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts, {
        window = {
          completion = {
            border = BORDER_STYLE,
            winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:None",
          },
          documentation = {
            border = BORDER_STYLE,
            winhighlight = "Normal:CmpDoc",
          },
        },
      })
    end,
  },

  -- lazyvim.plugins.editor border
  {
    "which-key.nvim",
    opts = { win = { border = BORDER_STYLE } },
  },

  -- gitsigns border
  {
    "gitsigns.nvim",
    opts = { preview_config = { border = BORDER_STYLE } },
  },

  -- lazyvim.plugins.lsp border
  {
    "nvim-lspconfig",
    opts = function(_, opts)
      -- Set LspInfo border
      require("lspconfig.ui.windows").default_options.border = BORDER_STYLE
      return opts
    end,
  },
}
