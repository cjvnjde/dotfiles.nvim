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
}
