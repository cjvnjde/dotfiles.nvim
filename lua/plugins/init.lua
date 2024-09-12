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
  "williamboman/mason-lspconfig.nvim",
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "vue-language-server",
        "stylua",
        "css-lsp",
        "html-lsp",
        "typescript-language-server",
        "deno",
        "prettier",
        "eslint-lsp",
        "tailwindcss-language-server",
        "rust-analyzer",
        "rescript-language-server",
      },
      run_on_start = true,
    },
    dependencies = {
      { "williamboman/mason.nvim", config = true },
      "williamboman/mason-lspconfig.nvim",
    },
  },
  -- formatting
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = (require "configs.conform"),
  },

  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "windwp/nvim-ts-autotag",
    },
    opts = {
      ensure_installed = {
        "bash",
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "markdown",
        "markdown_inline",
        "rust",
      },
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

  -- autocomplition
  {
    "hrsh7th/nvim-cmp",
    opts = {
      sources = {
        { name = "nvim_lsp" },
        { name = "path" },
      },
    },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
    },
  },
  -- LSP
  -- lsp message notifications
  {
    "j-hui/fidget.nvim",
    config = true,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim", config = true },
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require "configs.lsp"
    end,
  },
}
