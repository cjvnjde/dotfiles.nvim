require "config.options" -- should be first
require "config.lazy"
require "config.autocmds"
require "config.typehint_autocmd"

local mappings = require "config.mappings"

vim.lsp.enable {
  "bashls",
  "codebookls",
  "cssls",
  "emmetls",
  "eslintls",
  "htmlls",
  "jsonls",
  "luals",
  "pythonls",
  "rustls",
  "sveltels",
  "tailwindls",
  "tsls",
}

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
