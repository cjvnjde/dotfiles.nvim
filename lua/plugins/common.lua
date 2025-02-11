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
    keys = require("mappings").trouble(),
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
