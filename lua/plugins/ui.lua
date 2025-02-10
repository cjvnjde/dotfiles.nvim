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
        lualine_c = { "filename" },
        lualine_x = {
          {
            "rest",
            icon = "",
            fg = "#428890",
          },
          "encoding",
          "fileformat",
          "filetype",
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

  -- Color highlighter for hex codes and color names
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  },

  -- Display keybindings in a popup
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    cmd = "WhichKey",
  },
}
