local mappings = require "config.mappings"
local nesting_rules = require "config.file_nesting_rules"

return {
  -- Theme configuration
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    lazy = false,
    opts = {
      flavour = "mocha",
      transparent_background = true,
    },
    config = function(self, opts)
      require(self.name).setup(opts)
      vim.cmd.colorscheme "catppuccin"
    end,
  },
  -- Status line configuration
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = {
          "filename",
          "filetype",
        },
        lualine_x = {
          {
            "rest",
            icon = "",
            fg = "#428890",
          },
          "encoding",
          "fileformat",
        },
        lualine_z = { "location" },
      },
    },
  },
  -- Add vertical indentation lines
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = true,
  },
  -- Display keybindings in a popup
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    cmd = "WhichKey",
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = true,
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    lazy = false,
    ---@module "neo-tree"
    ---@type neotree.Config?
    opts = {
      popup_border_style = "",
      nesting_rules = nesting_rules,
    },
    config = function(_, opts)
      require("neo-tree").setup(opts)
      mappings.neotree()
    end,
  },
  {
    "brenoprata10/nvim-highlight-colors",
    opts = {
      render = "virtual",
      enable_tailwind = true,
    },
  },
  -- lsp notification
  {
    "j-hui/fidget.nvim",
    opts = {
      notification = {
        window = { winblend = 0 },
      },
    },
  },
}
