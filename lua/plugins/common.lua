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
  -- LspSaga used only for breadcrumbs
  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    config = function()
      require("lspsaga").setup {}
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },
  {
    "brenoprata10/nvim-highlight-colors",
    opts = {
      render = "virtual",
      enable_tailwind = true,
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
