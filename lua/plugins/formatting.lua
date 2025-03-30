return {
  -- Automatically detect and set tab width
  "tpope/vim-sleuth",

  -- Auto-format files on save
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = {
      formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        svelte = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        jsonc = { "prettier" },
        yaml = { "prettier" },
        markdown = { "markdownlint" },
        graphql = { "prettier" },
        vue = { "prettier" },
        lua = { "stylua" },
        rust = { "rustfmt" },
      },
      format_after_save = {
        lsp_fallback = true,
      },
    },
    config = function(_, opts)
      require("conform").setup(opts)
      require("config.mappings").conform()
    end,
  },
}
