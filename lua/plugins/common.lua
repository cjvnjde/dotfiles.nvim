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
    "brenoprata10/nvim-highlight-colors",
    opts = {
      render = "virtual",
      enable_tailwind = true,
    },
  },
  {
    "j-hui/fidget.nvim",
  },
}
