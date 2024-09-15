local ensure_installed = require "lua.packages"

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
  -- formatting
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = (require "configs.conform"),
  },

  -- install additional tools
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "windwp/nvim-ts-autotag",
    },
    opts = {
      ensure_installed = ensure_installed.treesitter,
      auto_install = true,
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
      autotag = {
        enable = true,
        filetypes = { "html", "xml", "tsx", "typescriptreact", "javascriptreact" },
      },
    },
  },
  -- adds vertical lines
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = true,
  },
  -- file search / search tool
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = (require "configs.telescope"),
  },

  -- mason

  {
    "williamboman/mason.nvim",
    config = true,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = (require "configs.mason").mason_auto_install,
    dependencies = {
      { "williamboman/mason.nvim", config = true },
    },
  },

  -- show key bindings
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    cmd = "WhichKey",
  },
  {
    "antosha417/nvim-lsp-file-operations",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-tree.lua",
    },
    config = true,
  },
  -- LSP
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim", config = true },
      { "j-hui/fidget.nvim", opts = {} },
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      require "configs.lsp"
    end,
  },
  { -- Autocompletion
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
    config = function()
      require "configs.cmp"
    end,
  },
}
