return {
  -- tools
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
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
      },
    },
  },

  -- lsp servers
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ["*"] = {
          keys = {
            {
              "gr",
              "<cmd>Trouble lsp_references toggle focus=true auto_jump=true auto_close=true<cr>",
              mode = { "n" },
              desc = "LSP References (Trouble)",
              has = "reference",
            },
            {
              "gd",
              "<cmd>Trouble lsp_definitions toggle focus=true auto_jump=true<cr>",
              mode = { "n" },
              desc = "Goto Definition (Trouble)",
              has = "definition",
            },
            {
              "<leader>cf",
              mode = { "n", "v" },
              function()
                require("conform").format({ async = true, lsp_fallback = "fallback" })
              end,
              desc = "Conform format",
            },
          },
        },
      },
    },
  },
}
