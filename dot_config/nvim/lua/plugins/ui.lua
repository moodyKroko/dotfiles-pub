return {
  -- disabled UI packages
  { "indent-blankline.nvim", enabled = false },
  { "akinsho/bufferline.nvim", enabled = false },
  {
    "echasnovski/mini.indentscope",
    enabled = false,
  },

  -- status line
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        theme = "papercolor_light",
      },
    },
  },

  -- Notifications system
  {
    "rcarriga/nvim-notify",
    lazy = true,
    opts = {
      timeout = 3000,
      stages = "static",
      render = "default", -- "compact"
      background_colour = "#56B6C2", --#a9ff68
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
        virtual_text = false,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
          },
        },
      },
    },
  },

  {
    "nvimdev/dashboard-nvim",
    opts = function(_, opts)
      local logo = [[
███╗   ███╗ ██████╗  ██████╗ ██████╗ ██╗   ██╗██╗  ██╗██████╗  ██████╗ ██╗  ██╗ ██████╗ 
████╗ ████║██╔═══██╗██╔═══██╗██╔══██╗╚██╗ ██╔╝██║ ██╔╝██╔══██╗██╔═══██╗██║ ██╔╝██╔═══██╗
██╔████╔██║██║   ██║██║   ██║██║  ██║ ╚████╔╝ █████╔╝ ██████╔╝██║   ██║█████╔╝ ██║   ██║
██║╚██╔╝██║██║   ██║██║   ██║██║  ██║  ╚██╔╝  ██╔═██╗ ██╔══██╗██║   ██║██╔═██╗ ██║   ██║
██║ ╚═╝ ██║╚██████╔╝╚██████╔╝██████╔╝   ██║   ██║  ██╗██║  ██║╚██████╔╝██║  ██╗╚██████╔╝
╚═╝     ╚═╝ ╚═════╝  ╚═════╝ ╚═════╝    ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝ ╚═════╝ 
                                                                                        
      ]]
      logo = string.rep("\n", 8) .. logo .. "\n\n"
      opts.config.header = vim.split(logo, "\n")
    end,
  },
}