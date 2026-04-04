require "options"
require "autocmds"
require "lsp"
require "plugins/coding"
require "plugins/editor"
require "plugins/tools"
require "plugins/testing"
require "plugins/experimental"

require("config.pack").setup()

local mappings = require "config.mappings"

vim.schedule(function()
  mappings.global()
end)

vim.diagnostic.config {
  virtual_text = true,
  underline = true,
  update_in_insert = true,
  virtual_lines = false,
  signs = true,
  float = {
    border = "rounded",
    source = true,
  },
  severity_sort = true,
}
