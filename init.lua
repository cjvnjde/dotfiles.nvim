require "config.options" -- should be first
require "config.lazy"
require "config.autocmds"

local mappings = require "config.mappings"

vim.lsp.enable {
  -- lua
  "luals", -- lua-language-server
  -- typescript
  "tsls",
  -- css
  "cssls", -- css-lsp
  "tailwindls", -- tailwindcss-language-server
  -- html
  "htmlls", -- html-lsp
  -- eslint
  "eslintls", -- eslint-lsp
  -- json
  "jsonls", -- json-lsp
  -- emmet
  "emmetls", -- emmet-language-server
  -- bash
  "bashls", -- bash-language-server
  -- python
  "pythonls", -- python-lsp-server
  -- rust
  "rustls", -- rust-analyzer
  "cspell",
  "sveltels",
}

vim.schedule(function()
  mappings.global()
end)

vim.diagnostic.config {
  virtual_text = true,
  underline = true,
  update_in_insert = true,
  viltual_lines = true,
  signs = true,
  float = {
    border = "rounded",
    source = true,
  },
  severity_sort = true,
}
