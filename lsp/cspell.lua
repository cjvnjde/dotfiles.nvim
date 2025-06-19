-- npm install -g @vlabo/cspell-lsp

return {
  cmd = { "cspell-lsp", "--stdio" },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
    "gitcommit",
  },
  root_markers = { ".git" },
}
