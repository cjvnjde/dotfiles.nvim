local M = {
  mason = {
    -- lsp
    "bash-language-server",
    "codebook",
    "css-lsp",
    "emmet-language-server",
    "eslint-lsp",
    "html-lsp",
    "json-lsp",
    "lua-language-server",
    -- "python-lsp-server",
    -- "rust-analyzer",
    "svelte-language-server",
    "tailwindcss-language-server",
    "typescript-language-server",

    -- linter/formatter
    "stylua",
    "prettier",
    "markdownlint",

    -- others
    "sql-formatter",
    "jq",
  },
  -- @see https://github.com/nvim-treesitter/nvim-treesitter/blob/main/SUPPORTED_LANGUAGES.md
  treesitter = {
    "bash",
    "css",
    "html",
    "http",
    "javascript",
    "jsdoc",
    "json",
    "lua",
    "markdown",
    "markdown_inline",
    -- "python",
    -- "rust",
    "sql",
    "svelte",
    "toml",
    "tsx",
    "typescript",
    "yaml",
  },
}

return M
