local packages = require "config.mason_packages"

vim.g.db_ui_use_nerd_fonts = 1

-- Mason START
-- Tool installer for LSP servers, linters, and formatters
vim.pack.add {
  "https://github.com/williamboman/mason.nvim",
  "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
}

require("mason").setup()

require("mason-tool-installer").setup {
  ensure_installed = packages,
  run_on_start = true,
}
-- Mason END

-- Dadbod START
-- Database client UI
vim.pack.add {
  "https://github.com/tpope/vim-dadbod",
  "https://github.com/kristijanhusak/vim-dadbod-completion",
  "https://github.com/kristijanhusak/vim-dadbod-ui",
}
-- Dadbod END

-- Kulala START
-- HTTP client for REST requests
vim.pack.add {
  "https://github.com/mistweaverco/kulala.nvim",
}

require("kulala").setup {
  global_keymaps = false,
  global_keymaps_prefix = "<leader>R",
  kulala_keymaps_prefix = "",
}
-- Kulala END

-- AI Commit START
-- Generate commit messages with AI
vim.pack.add {
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-telescope/telescope.nvim",
  "https://github.com/cjvnjde/ai-provider.nvim",
  "https://github.com/cjvnjde/ai-commit.nvim",
}

require("ai-commit").setup {
  provider = "github-copilot",
  model = "gpt-5-mini",
  ai_options = {
    reasoning = "low",
  },
  ignored_files = {
    "package-lock.json",
    "yarn.lock",
    "pnpm-lock.yaml",
    "lazy-lock.json",
  },
}
-- AI Commit END

-- Copilot START
-- GitHub Copilot integration
vim.pack.add {
  "https://github.com/github/copilot.vim",
}
-- Copilot END

-- Markdown Preview START
-- Preview markdown files in browser
vim.pack.add {
  "https://github.com/selimacerbas/live-server.nvim",
  "https://github.com/selimacerbas/markdown-preview.nvim",
}
-- Markdown Preview END
