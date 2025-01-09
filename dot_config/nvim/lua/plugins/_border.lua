-- Set border of some LazyVim plugins to rounded
local BORDER_STYLE = "rounded"

return {
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
