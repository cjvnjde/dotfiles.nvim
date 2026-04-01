local mappings = require "config.mappings"

local is_log = function(entry)
  return entry.label == "log" and entry.source_name == "Snippets"
end

-- Blink CMP START
-- Autocompletion engine
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
}
-- Blink CMP END

-- Treesitter START
-- Syntax highlighting and code parsing
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
-- Treesitter END

-- Treesitter Autoinstall START
-- Automatically install treesitter parsers
vim.pack.add {
  "https://github.com/mks-h/treesitter-autoinstall.nvim",
}

require("treesitter-autoinstall").setup()
-- Treesitter Autoinstall END

-- Vim Sleuth START
-- Automatically detect and set tab width
vim.pack.add {
  "https://github.com/tpope/vim-sleuth",
}
-- Vim Sleuth END

-- Conform START
-- Auto-format files on save
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
-- Conform END

-- LSP Config START
vim.pack.add {
  "https://github.com/neovim/nvim-lspconfig",
}
-- LSP Config END

-- LSP File Operations START
-- Automatically update imports on file rename/move
vim.pack.add {
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-neo-tree/neo-tree.nvim",
  "https://github.com/antosha417/nvim-lsp-file-operations",
}

require("lsp-file-operations").setup()
-- LSP File Operations END
