vim.g.db_ui_use_nerd_fonts = 1

return {
  -- Git integration
  {
    "lewis6991/gitsigns.nvim",
    opts = function()
      local mappings = require "config.mappings"

      return {
        current_line_blame = true,
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
          mappings.gitsigns(gs, bufnr)
        end,
      }
    end,
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "marilari88/neotest-vitest",
      "cjvnjde/neotest-jest",
    },
    config = function()
      require("neotest").setup {
        discovery = {
          enabled = false,
        },
        adapters = {
          require "neotest-vitest",
          require "neotest-jest",
        },
      }
      require("config.mappings").neotest()
    end,
  },
  {
    "andythigpen/nvim-coverage",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      auto_reload = true,
    },
    config = function(_, opts)
      require("coverage").setup(opts)
      require("config.mappings").coverage()
    end,
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
    -- dir = "/ai-commit.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    opts = {
      env = {
        api_key = os.getenv "OPENROUTER_API_KEY",
        url = "https://openrouter.ai/api",
        chat_url = "/v1/chat/completions",
      },
      model = "x-ai/grok-4-fast",
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
