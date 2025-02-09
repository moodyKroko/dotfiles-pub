return {
  -- disabled UI packages
  { "akinsho/bufferline.nvim", enabled = false },

  {
    "folke/noice.nvim",
    opts = function(_, opts)
      opts.debug = false
      opts.routes = opts.routes or {}

      opts.presets = { lsp_doc_border = true }

      opts.lsp = {
        hover = {
          silent = true, -- set to true to not show a message if hover is not available
        },
      }

      table.insert(opts.routes, {
        filter = {
          event = "notify",
          find = "No information available",
        },
        opts = { skip = true },
      })
      local focused = true
      vim.api.nvim_create_autocmd("FocusGained", {
        callback = function()
          focused = true
        end,
      })
      vim.api.nvim_create_autocmd("FocusLost", {
        callback = function()
          focused = false
        end,
      })

      table.insert(opts.routes, 1, {
        filter = {
          ["not"] = {
            event = "lsp",
            kind = "progress",
          },
          cond = function()
            return not focused and false
          end,
        },
        view = "notify_send",
        opts = { stop = false, replace = true },
      })

      -- ignore lsp servers progress message
      table.insert(opts.routes, {
        filter = {
          event = "lsp",
          kind = "progress",
        },
        opts = { skip = true },
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function(event)
          vim.schedule(function()
            require("noice.text.markdown").keys(event.buf)
          end)
        end,
      })
      return opts
    end,
  },
  -- {
  -- "folke/noice.nvim",
  -- opts = {
  --   cmdline = {
  --     -- enabled = true, -- disable to use default cmdline
  --     view = "cmdline_input2",
  --   },
  --
  --   lsp = {
  --     hover = {
  --       silent = true, -- set to true to not show a message if hover is not available
  --     },
  --   },
  --
  --   views = {
  --     cmdline_input2 = {
  --       view = "cmdline_popup",
  --       position = { row = "97%", col = "5%" },
  --       border = { style = "rounded", padding = { 0, 1 } },
  --     },
  --
  --     popupmenu = {
  --       relative = "editor",
  --       position = {
  --         row = "86%",
  --         col = "2%",
  --       },
  --       border = {
  --         style = "rounded",
  --       },
  --       win_options = {
  --         winhighlight = "Normal:Normal,TelescopeBorder:Normal",
  --       },
  --     },
  --   },
  --
  --   presets = {
  --     bottom_search = false,
  --     command_palette = false,
  --     lsp_doc_border = true,
  --   },
  -- },
  -- },

  -- status line
  {
    "nvim-lualine/lualine.nvim",
    -- enabled = false,
    opts = {
      options = {
        theme = "catppuccin", --"ayu_dark", --"iceberg_dark",
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
      },
      sections = {
        lualine_c = {
          {
            "diagnostics",
            symbols = {
              error = " ",
              warn = "󰀪 ",
              info = "󰌶 ",
              hint = " ",
            },
          },
          { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          { LazyVim.lualine.pretty_path() },
        },
      },
    },
  },

  -- rainbow brackets
  {
    "hiphish/rainbow-delimiters.nvim",
    event = "BufReadPre",
  },

  -- mason signs
  {
    "williamboman/mason.nvim",
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
        border = "rounded",
      },
    },
  },

  {
    "LazyVim/LazyVim",
    opts = {
      icons = {
        diagnostics = {
          Error = " ",
        },
      },
    },
  },

  {
    "nvim-lspconfig",
    opts = {
      diagnostics = {
        virtual_text = true,
        update_in_insert = false,
        float = {
          focusable = false,
          style = "minimal",
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = "󰀪 ",
            [vim.diagnostic.severity.HINT] = "󰌶 ",
            [vim.diagnostic.severity.INFO] = " ",
          },
        },
      },
    },
  },

  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      scroll = { enabled = false },
      indent = { enabled = false },
      picker = {
        matcher = {
          frecency = true,
        },
      },
      dashboard = {
        preset = {
          header = [[
 ███╗   ███╗ ██████╗  ██████╗ ██████╗ ██╗   ██╗██╗  ██╗██████╗  ██████╗ ██╗  ██╗ ██████╗ 
 ████╗ ████║██╔═══██╗██╔═══██╗██╔══██╗╚██╗ ██╔╝██║ ██╔╝██╔══██╗██╔═══██╗██║ ██╔╝██╔═══██╗
 ██╔████╔██║██║   ██║██║   ██║██║  ██║ ╚████╔╝ █████╔╝ ██████╔╝██║   ██║█████╔╝ ██║   ██║
 ██║╚██╔╝██║██║   ██║██║   ██║██║  ██║  ╚██╔╝  ██╔═██╗ ██╔══██╗██║   ██║██╔═██╗ ██║   ██║
 ██║ ╚═╝ ██║╚██████╔╝╚██████╔╝██████╔╝   ██║   ██║  ██╗██║  ██║╚██████╔╝██║  ██╗╚██████╔╝
 ╚═╝     ╚═╝ ╚═════╝  ╚═════╝ ╚═════╝    ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝ ╚═════╝
          ]],
        },
      },
    },
  },
}
