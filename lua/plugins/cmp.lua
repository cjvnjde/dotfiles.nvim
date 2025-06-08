local mappings = require "config.mappings"

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
      completion = { documentation = { auto_show = false } },
      signature = { enabled = true },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },

        per_filetype = {
          codecompanion = { "codecompanion" },
        },
      },
      fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
  },
}
