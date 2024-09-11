return {
  -- theme
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
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    opts = (require "configs.nvimtree"),
  },
  -- add/update/delete surrounding pairs
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = true,
  },
  -- auto tab width
  "tpope/vim-sleuth",
  -- install additional tools
  {
    "williamboman/mason.nvim",
    config = true,
  },
  -- formatting
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = (require "configs.conform"),
  },
}
