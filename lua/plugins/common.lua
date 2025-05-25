return {
  -- Extended text objects for selection
  {
    "echasnovski/mini.nvim",
    main = "mini.ai",
    config = true,
  },

  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    config = true,
    keys = require("config.mappings").trouble(),
  },
  {
    "nvimdev/lspsaga.nvim",
    config = function()
      require("lspsaga").setup {}
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },

  -- {
  --   "rest-nvim/rest.nvim",
  --   config = function()
  --     ---@class rest.Config
  --     local config = {
  --       env = {
  --         pattern = ".*%.http.env.*",
  --       },
  --     }
  --
  --     vim.g.rest_nvim = config
  --
  --     require("config.mappings").rest()
  --   end,
  -- },

  -- {
  --   "alunny/pegjs-vim",
  --   lazy = true,
  -- },
}
