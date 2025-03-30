local M = {
  mason = {
    -- lsp
    "lua-language-server",
    "typescript-language-server",
    "css-lsp",
    "html-lsp",
    "eslint-lsp",
    "tailwindcss-language-server",
    "json-lsp",
    "emmet-language-server",
    "bash-language-server",
    "python-lsp-server",
    "rust-analyzer",

    -- "vue-language-server",
    -- "rescript-language-server"

    -- linter/formatter
    "stylua",
    "prettier",
    "markdownlint",
    "eslint_d",

    -- others
    "deno",
  },
  treesitter = {
    "bash",
    "vim",
    "lua",
    "vimdoc",
    "html",
    "css",
    "javascript",
    "typescript",
    "tsx",
    "markdown",
    "markdown_inline",
    "rust",
    "json",
    "http",
    "vue",
    "python",
    "yaml",
    "sql",
    "toml",
    "jsdoc",
  },
}

return M
