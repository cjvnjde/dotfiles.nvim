local packages = require "config.mason_packages"

vim.g.db_ui_use_nerd_fonts = 1

return {
  -- Tool installer for LSP, linters, and formatters
  {
    "williamboman/mason.nvim",
    config = true,
  },

  -- Auto-install tools using Mason
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = packages,
      run_on_start = true,
    },
    dependencies = { { "williamboman/mason.nvim", config = true } },
  },
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql" }, lazy = true },
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
  },
  {
    "mistweaverco/kulala.nvim",
    keys = {
      { "<leader>Rs", desc = "Send request" },
      { "<leader>Ra", desc = "Send all requests" },
      { "<leader>Rb", desc = "Open scratchpad" },
    },
    ft = { "http", "rest" },
    opts = {
      global_keymaps = false,
      global_keymaps_prefix = "<leader>R",
      kulala_keymaps_prefix = "",
    },
  },
  {
    "cjvnjde/ai-commit.nvim",
    -- dir = "/nvim-plugins/ai-commit.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      -- { dir = "/nvim-plugins/ai-provider.nvim" },
      "cjvnjde/ai-provider.nvim",
    },
    opts = {
      provider = "github-copilot",
      model = "gpt-5-mini",
      ignored_files = {
        "package-lock.json",
        "yarn.lock",
        "pnpm-lock.yaml",
        "lazy-lock.json",
      },
      -- debug = true,
    },
  },
}
