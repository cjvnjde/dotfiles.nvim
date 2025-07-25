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
}

vim.schedule(function()
  mappings.global()
end)

vim.diagnostic.config { virtual_text = true }
