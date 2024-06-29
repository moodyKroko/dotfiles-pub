return {
  { "folke/flash.nvim", enabled = false },
  { "folke/persistence.nvim", enabled = false },

  -- telescope
  {
    "nvim-telescope/telescope.nvim",
    lazy = true,
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.5,
          },
          width = 0.8,
          height = 0.8,
          preview_cutoff = 120,
        },
        sorting_strategy = "ascending",
        winblend = 0,
        border = {
          enabled = true,
        },
        mappings = {
          i = {
            ["<c-d>"] = require("telescope.actions").delete_buffer,
          },
        },
      },
    },
  },

  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        -- "comment", -- comments are slowing down TS bigtime, so disable for now
        "css",
        "gitcommit",
        "gitignore",
        "http",
      })
    end,
  },

  -- auto sessions
  {
    "rmagatti/auto-session",
    -- event = { { "VimLeavePre" } }, -- { "VimEnter", "VimLeavePre" },
    lazy = false,
    config = function()
      require("auto-session").setup({
        log_level = vim.log.levels.ERROR,
        auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/", "$HOME" }, -- "C:\\", "C:\\Users\\james"
        auto_session_use_git_branch = false,
        -- pre_save_cmds = { "Neotree close" },
      })

      vim.diagnostic.config({
        -- update_in_insert = true,
        float = {
          focusable = false,
          style = "minimal",
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
      })
    end,
    keys = {
      {
        "<leader>fs",
        function()
          require("auto-session.session-lens").search_session()
        end,
        desc = "Search for a session",
      },
    },
  },

  -- trouble
  {
    "folke/trouble.nvim",
    keys = {
      {
        "<leader>cS",
        "<cmd>Trouble lsp toggle focus=false<cr>",
        desc = "LSP references/definitions/... (Trouble)",
      },
    },
  },

  {
    "sindrets/diffview.nvim",
    lazy = true,
    opts = {},
    cmd = "DiffviewOpen",
    keys = {
      {
        "<leader>dvo",
        "<cmd>DiffviewOpen<cr>",
        mode = { "n" },
        desc = "Open a diff view in another tab",
      },
    },
  },

  {
    "which-key.nvim",
    opts = {
      defaults = {
        ["<leader>dv"] = { name = "+diffview" },
      },
    },
  },
}
