return {
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
}
