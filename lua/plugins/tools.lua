local M = {}

require("mason").setup()
require("mason-tool-installer").setup {
  ensure_installed = require "config.mason_packages",
  run_on_start = false, -- Provision explicitly with :MasonToolsInstall / :MasonToolsUpdate.
}
require("which-key").setup()

-- Dadbod's commands and SQL completion already use Vim's native autoload.
vim.g.db_ui_use_nerd_fonts = 1

return M
