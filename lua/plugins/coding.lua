local mappings = require "config.mappings"

-- Blink CMP {{{1
-- Autocompletion engine.
vim.pack.add {
  "https://github.com/rafamadriz/friendly-snippets",
  {
    src = "https://github.com/saghen/blink.cmp",
    version = vim.version.range "1",
  },
}

require("blink.cmp").setup {
  keymap = mappings.blink,
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
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    if ev.data.spec.name == "nvim-treesitter" and (ev.data.kind == "install" or ev.data.kind == "update") then
      vim.cmd "TSUpdate"
    end
  end,
})

vim.pack.add {
  "https://github.com/nvim-treesitter/nvim-treesitter",
}
-- }}}

-- Treesitter Autoinstall {{{1
-- Automatically install Tree-sitter parsers.
vim.pack.add {
  "https://github.com/mks-h/treesitter-autoinstall.nvim",
}

require("treesitter-autoinstall").setup()
-- }}}

-- Vim Sleuth {{{1
-- Automatically detect and set tab width.
vim.pack.add {
  "https://github.com/tpope/vim-sleuth",
}
-- }}}

-- Conform {{{1
-- Auto-format files on save.
vim.pack.add {
  "https://github.com/stevearc/conform.nvim",
}

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
    lua = { "stylua" },
    rust = { "rustfmt" },
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
    lsp_fallback = true,
  },
}

mappings.conform()
-- }}}

-- LSP Config {{{1
-- Core LSP client configuration.
vim.pack.add {
  "https://github.com/neovim/nvim-lspconfig",
}
-- }}}

-- LSP File Operations {{{1
-- Automatically update imports on file rename or move.
vim.pack.add {
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-neo-tree/neo-tree.nvim",
  "https://github.com/antosha417/nvim-lsp-file-operations",
}

require("lsp-file-operations").setup()
-- }}}

-- vim: set fdm=marker fdl=0 fen:
