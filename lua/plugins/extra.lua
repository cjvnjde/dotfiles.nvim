return {
  -- file explorer that lets you edit your filesystem like a normal Neovim buffer
  {
    "stevearc/oil.nvim",
    config = true,
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  -- vim testing plugin
  -- {
  --   "nvim-neotest/neotest",
  --   dependencies = {
  --     "nvim-neotest/nvim-nio",
  --     "nvim-lua/plenary.nvim",
  --     "antoinemadec/FixCursorHold.nvim",
  --     "nvim-treesitter/nvim-treesitter",
  --     "nvim-neotest/neotest-jest",
  --   },
  --   config = function()
  --     require("neotest").setup {
  --       discovery = {
  --         enabled = false,
  --       },
  --       adapters = {
  --         require "neotest-jest" {
  --           jest_test_discovery = false,
  --           jestCommand = "npm test -- collectCoverage=true",
  --           jestConfigFile = "jest.config.ts",
  --           env = { CI = true },
  --           cwd = function()
  --             return vim.fn.getcwd()
  --           end,
  --         },
  --       },
  --     }
  --   end,
  -- },
  -- vim testing coverage
  -- {
  --   "andythigpen/nvim-coverage",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --   },
  --   config = function()
  --     require("coverage").setup {
  --       auto_reload = true,
  --     }
  --   end,
  -- },
  -- working with database
  -- {
  --   "kristijanhusak/vim-dadbod-ui",
  --   dependencies = {
  --     { "tpope/vim-dadbod", lazy = true },
  --     { "kristijanhusak/vim-dadbod-completion", ft = { "sql" }, lazy = true },
  --   },
  --   cmd = {
  --     "DBUI",
  --     "DBUIToggle",
  --     "DBUIAddConnection",
  --     "DBUIFindBuffer",
  --   },
  -- },
}
