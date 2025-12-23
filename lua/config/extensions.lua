local M = {
  mason = {
    -- lsp
    "bash-language-server",
    "css-lsp",
    "emmet-language-server",
    "eslint-lsp",
    "html-lsp",
    "json-lsp",
    "lua-language-server",
    "python-lsp-server",
    "rust-analyzer",
    "tailwindcss-language-server",
    "typescript-language-server",
    "svelte-language-server",

    -- "vue-language-server",
    -- "rescript-language-server"

    -- linter/formatter
    "stylua",
    "prettier",
    "markdownlint",
    "eslint_d",

    -- others
    "deno",
    "sql-formatter",
    "jq",
    "codebook",
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
    "svelte",
  },
}

return M
