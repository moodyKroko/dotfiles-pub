return {
  -- tools
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "shellcheck",
        -- "luacheck",
        -- "tailwindcss-language-server",
        -- "typescript-language-server",
        "gopls",
        "goimports",
        "gofumpt",
        "delve",
        "gomodifytags",
        "impl",
        "json-lsp",
        "css-lsp",
      })
    end,
  },

  -- lsp servers
  {
    "neovim/nvim-lspconfig",
    opts = {
      ---@type lspconfig.options
      servers = {
        cssls = {},
      }
    }
  }
}
