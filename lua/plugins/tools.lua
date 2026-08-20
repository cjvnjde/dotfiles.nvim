local packages = require "config.mason_packages"

-- Mason {{{1
-- Tool installer for LSP servers, linters, and formatters.
vim.pack.add {
  "https://github.com/williamboman/mason.nvim",
  "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
}

require("mason").setup()

require("mason-tool-installer").setup {
  ensure_installed = packages,
  run_on_start = true,
}
-- }}}

-- Dadbod {{{1
-- Database client UI and completion.
vim.g.db_ui_use_nerd_fonts = 1

vim.pack.add {
  "https://github.com/tpope/vim-dadbod",
  "https://github.com/kristijanhusak/vim-dadbod-completion",
  "https://github.com/kristijanhusak/vim-dadbod-ui",
}
-- }}}

-- Kulala {{{1
-- HTTP client for REST requests.
vim.pack.add {
  "https://github.com/mistweaverco/kulala.nvim",
}

require("kulala").setup {
  global_keymaps = false,
  global_keymaps_prefix = "<leader>R",
  kulala_keymaps_prefix = "",
}
-- }}}

-- Which Key {{{1
-- Display keybindings in a popup.
vim.pack.add {
  "https://github.com/folke/which-key.nvim",
}

require("which-key").setup()
-- }}}

-- vim: set fdm=marker fdl=0 fen:
