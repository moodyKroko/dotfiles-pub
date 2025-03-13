return {
  -- maybe add stevearc/quicker.nvim

  {
    "saghen/blink.cmp",
    opts = {
      -- required for supertab and autocomplete selection
      snippets = {
        expand = function(snippet)
          require("luasnip").lsp_expand(snippet)
        end,
        active = function(filter)
          if filter and filter.direction then
            return require("luasnip").jumpable(filter.direction)
          end
          return require("luasnip").in_snippet()
        end,
        jump = function(direction)
          require("luasnip").jump(direction)
        end,
      },
      completion = {
        -- required for supertab and autocomplete selection
        trigger = {
          show_in_snippet = false,
        },
        menu = {
          min_width = 20,
          border = "rounded",
          draw = {
            components = {
              source = {
                text = function(ctx)
                  local map = {
                    ["lsp"] = "[]",
                    ["path"] = "[󰉋]",
                    ["snippets"] = "[]",
                  }
                  return map[ctx.item.source_id]
                end,
              },
            },
          },
        },
        documentation = {
          window = {
            border = "rounded",
          },
        },
      },

      signature = {
        window = {
          border = "rounded",
        },
      },

      appearance = {
        kind_icons = {
          Snippet = "",
        },
      },

      keymap = {
        -- required for supertab and autocomplete selection
        -- enable autocomplete selection with <Tab>
        ["<Tab>"] = {
          function(cmp)
            if cmp.snippet_active() then
              return cmp.accept()
            else
              return require("blink.cmp").select_next()
            end
          end,
          "snippet_forward",
          "fallback",
        },
        ["<S-Tab>"] = {
          "select_prev",
          "snippet_backward",
          "fallback",
        },
      },
    },
  },
}
