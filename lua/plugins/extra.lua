return {
  -- file explorer that lets you edit your filesystem like a normal Neovim buffer
  {
    "stevearc/oil.nvim",
    config = true,
    dependencies = { "nvim-tree/nvim-web-devicons" },
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
    end,
  },
  {
    "andythigpen/nvim-coverage",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("coverage").setup {
        auto_reload = true,
      }
    end,
  },
  -- working with database
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
    "rest-nvim/rest.nvim",
    config = function()
      ---@class rest.Config
      local config = {
        env = {
          pattern = ".*%.http.env.*",
        },
      }

      vim.g.rest_nvim = config
    end,
  },

  {
    "mikesmithgh/kitty-scrollback.nvim",
    enabled = true,
    lazy = true,
    cmd = { "KittyScrollbackGenerateKittens", "KittyScrollbackCheckHealth" },
    event = { "User KittyScrollbackLaunch" },
    config = function()
      require("kitty-scrollback").setup {
        {
          paste_window = {
            yank_register_enabled = false,
          },
        },
      }
    end,
  },
  {
    "github/copilot.vim",
  },
}
