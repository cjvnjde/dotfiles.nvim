-- Blink CMP {{{1
-- Autocompletion engine.

require("blink.cmp").setup {
  keymap = require("config.mappings").blink,
  appearance = {
    nerd_font_variant = "mono",
  },
  completion = {
    documentation = { auto_show = true },
    list = { selection = { preselect = true, auto_insert = false } },
  },
  signature = { enabled = true },
  sources = {
    default = { "snippets", "lsp", "path", "buffer" },
    per_filetype = {
      sql = { "snippets", "dadbod", "buffer" },
    },
    providers = {
      dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
    },
  },
  fuzzy = {
    implementation = "prefer_rust_with_warning",
  },
}
-- }}}

-- Treesitter {{{1
-- Syntax highlighting and parser management.

-- Use the stable bash parser for zsh files.
vim.treesitter.language.register("bash", "zsh")
-- }}}

-- Treesitter Autoinstall {{{1
-- Automatically install Tree-sitter parsers.
require("treesitter-autoinstall").setup()
-- }}}

-- Conform {{{1
-- Auto-format files on save.
require("conform").setup {
  formatters_by_ft = {
    javascript = { "prettier" },
    typescript = { "prettier" },
    javascriptreact = { "prettier" },
    typescriptreact = { "prettier" },
    svelte = { "prettier" },
    css = { "prettier" },
    html = { "prettier" },
    json = { "prettier" },
    jsonc = { "prettier" },
    yaml = { "prettier" },
    markdown = { "markdownlint" },
    graphql = { "prettier" },
    vue = { "prettier" },
    gdscript = { "gdscript-formatter" },
    lua = { "stylua" },
    sql = { "sql_formatter" },
  },
  formatters = {
    sql_formatter = {
      args = {
        "--language",
        "postgresql",
        "--config",
        '{"keywordCase":"upper","functionCase":"upper","dataTypeCase":"upper"}',
      },
    },
  },
  format_after_save = {
    lsp_format = "fallback",
  },
}
-- }}}

-- LSP File Operations {{{1
-- Automatically update imports on file rename or move.
require("nvim-file-operations").setup()
vim.lsp.config("*", {
  capabilities = require("nvim-file-operations.config").default_capabilities(),
})
-- }}}

-- vim: set fdm=marker fdl=0 fen:
