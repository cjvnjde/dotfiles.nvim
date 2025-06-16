local mappings = require "config.mappings"

local is_log = function(entry)
  return entry.label == "log" and entry.source_name == "Snippets"
end

return {
  {
    "saghen/blink.cmp",
    dependencies = { "L3MON4D3/LuaSnip", "Kaiser-Yang/blink-cmp-avante" },
    version = "1.*",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      snippets = { preset = "luasnip" },
      keymap = mappings.blink,
      appearance = {
        nerd_font_variant = "mono",
      },
      completion = {
        documentation = { auto_show = true },
        menu = {
          draw = {
            components = {
              kind_icon = {
                text = function(ctx)
                  local icon = ctx.kind_icon

                  if ctx.item.source_name == "LSP" then
                    local color_item =
                      require("nvim-highlight-colors").format(ctx.item.documentation, { kind = ctx.kind })
                    if color_item and color_item.abbr ~= "" then
                      icon = color_item.abbr
                    end
                  end
                  return icon .. ctx.icon_gap
                end,
                highlight = function(ctx)
                  local highlight = "BlinkCmpKind" .. ctx.kind
                  if ctx.item.source_name == "LSP" then
                    local color_item =
                      require("nvim-highlight-colors").format(ctx.item.documentation, { kind = ctx.kind })
                    if color_item and color_item.abbr_hl_group then
                      highlight = color_item.abbr_hl_group
                    end
                  end
                  return highlight
                end,
              },
            },
          },
        },
      },
      signature = { enabled = true },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },

        per_filetype = {
          codecompanion = { "codecompanion" },
          sql = { "snippets", "dadbod", "buffer" },
        },
        providers = {
          dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
        },
      },
      fuzzy = {
        implementation = "prefer_rust_with_warning",
        sorts = {
          function(a, b)
            if is_log(a) and not is_log(b) then
              return true
            end
            if is_log(b) and not is_log(a) then
              return false
            end
          end,
          "score",
          "sort_text",
        },
      },
    },
    opts_extend = { "sources.default" },
  },
}
