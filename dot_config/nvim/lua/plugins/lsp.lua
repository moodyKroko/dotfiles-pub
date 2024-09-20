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
    opts = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()

      keys[#keys + 1] = {
        "gr",
        "<cmd>Trouble lsp_references toggle focus=true auto_jump=true<cr>",
        mode = { "n" },
        desc = "LSP References (Trouble)",
      }

      keys[#keys + 1] = {
        "gd",
        "<cmd>Trouble lsp_definitions toggle focus=true auto_jump=true<cr>",
        mode = { "n" },
        desc = "LSP Definitions (Trouble)",
      }
    end,
  },
}