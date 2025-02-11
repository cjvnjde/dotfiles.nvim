local extensions = require "extensions"
local mappings = require "mappings"

return {
  -- Treesitter for enhanced syntax highlighting and indentation
  {
    "nvim-treesitter/nvim-treesitter",
    main = "nvim-treesitter.configs",
    opts = {
      ensure_installed = extensions.treesitter,
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    },
  },

  -- Extended text objects for selection
  {
    "echasnovski/mini.nvim",
    main = "mini.ai",
    config = true,
  },

  {
    "ggandor/leap.nvim",
    dependencies = "tpope/vim-repeat",
    config = function()
      require("mappings").leap()
    end,
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("harpoon"):setup {}
      require("mappings").harpoon()
    end,
  },
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    config = true,
    keys = mappings.trouble(),
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

      require("mappings").rest()
    end,
  },

  {
    "alunny/pegjs-vim",
    lazy = true,
  },
}
