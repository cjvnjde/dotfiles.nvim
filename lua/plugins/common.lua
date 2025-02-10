local ensure_installed = require "language_tools"
local mappings = require "mappings"

return {

  -- Treesitter for enhanced syntax highlighting and indentation
  {
    "nvim-treesitter/nvim-treesitter",
    main = "nvim-treesitter.configs",
    opts = {
      ensure_installed = ensure_installed.treesitter,
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    },
  },

  -- Fuzzy finder and search tool
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = (require "configs.telescope"),
  },

  -- Tool installer for LSP, linters, and formatters
  {
    "williamboman/mason.nvim",
    config = true,
  },

  -- Auto-install tools using Mason
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = (require "configs.mason").mason_auto_install,
    dependencies = { { "williamboman/mason.nvim", config = true } },
  },

  -- File operations support with LSP
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

  -- LSP configuration and dependencies
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim", config = true },
      {
        "j-hui/fidget.nvim",
        opts = {
          progress = {
            ignore = {
              function(msg)
                return msg.lsp_client.name == "pylsp" and string.find(msg.title, "lint:")
              end,
            },
          },
        },
      },
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      require "configs.lsp"
    end,
  },

  -- Autocompletion engine
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

  -- Git integration
  {
    "lewis6991/gitsigns.nvim",
    opts = function()
      local opts = require "configs.gitsigns"
      return opts
    end,
  },

  -- Extended text objects for selection
  {
    "echasnovski/mini.nvim",
    main = "mini.ai",
    config = true,
  },

  -- Snippet engine and snippets library
  {
    "L3MON4D3/LuaSnip",
    version = "v2.3.0",
    build = "make install_jsregexp",
    dependencies = "rafamadriz/friendly-snippets",
    config = function()
      require "configs.luasnip"
    end,
  },

  {
    "ggandor/leap.nvim",
    dependencies = "tpope/vim-repeat",
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = true,
  },
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    config = true,
    keys = mappings.trouble(),
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
    end,
  },

  {
    "alunny/pegjs-vim",
    lazy = true,
  },
  -- {
  --   "folke/noice.nvim",
  --   event = "VeryLazy",
  --   opts = {
  --     lsp = {
  --       override = {
  --         ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
  --         ["vim.lsp.util.stylize_markdown"] = true,
  --         ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
  --       },
  --     },
  --     presets = {
  --       bottom_search = true, -- use a classic bottom cmdline for search
  --       command_palette = true, -- position the cmdline and popupmenu together
  --       long_message_to_split = true, -- long messages will be sent to a split
  --       inc_rename = false, -- enables an input dialog for inc-rename.nvim
  --       lsp_doc_border = false, -- add a border to hover docs and signature help
  --     },
  --   },
  --   dependencies = {
  --     "MunifTanjim/nui.nvim",
  --   },
  -- },
}
