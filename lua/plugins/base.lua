local ensure_installed = require "packages"

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
  -- file explorer
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
  -- automatically detect tab width
  "tpope/vim-sleuth",

  -- auto close pairs such as brackets and quotes
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },
  -- formatting on save
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = (require "configs.conform"),
  },

  {
    "windwp/nvim-ts-autotag",
    opts = {
      opts = {
        enable_close = true,
        enable_rename = true,
        enable_close_on_slash = true,
      },
    },
  },

  -- treesitter for syntax highlighting and more
  {
    "nvim-treesitter/nvim-treesitter",
    main = "nvim-treesitter.configs",
    opts = {
      ensure_installed = ensure_installed.treesitter,
      auto_install = true,
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
    },
  },

  -- adds vertical indentation lines
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = true,
  },

  -- fuzzy finder and search tool
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = (require "configs.telescope"),
  },

  -- mason for managing external tools like LSP servers, linters, and formatters
  {
    "williamboman/mason.nvim",
    config = true,
  },
  -- auto install tools with mason
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = (require "configs.mason").mason_auto_install,
    dependencies = {
      { "williamboman/mason.nvim", config = true },
    },
  },

  -- show keybindings in a popup
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    cmd = "WhichKey",
  },
  -- LSP file operations support
  {
    "antosha417/nvim-lsp-file-operations",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-tree.lua",
    },
    opts = {
      operations = {
        willRenameFiles = true,
        didRenameFiles = true,
        willCreateFiles = true,
        didCreateFiles = true,
        willDeleteFiles = true,
        didDeleteFiles = true,
      },
    },
  },
  -- LSP configurations and dependencies
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
  -- autocompletion engine
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      require "configs.cmp"
    end,
  },
  -- [[GIT]]
  {
    "lewis6991/gitsigns.nvim",
    opts = function()
      local opts = require "configs.gitsigns"

      return opts
    end,
  },
  -- Bottom line
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { "filename" },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = {},
        lualine_z = { "location" },
      },
    },
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  },

  -- extend a and i textobjects
  {
    "echasnovski/mini.nvim",
    main = "mini.ai",
    config = true,
  },

  {
    "L3MON4D3/LuaSnip",
    version = "v2.3.0",
    build = "make install_jsregexp",
    dependencies = "rafamadriz/friendly-snippets",
    config = function()
      require "configs.luasnip"
    end,
  },
}
