local mappings = require "config.mappings"

return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "v0.2.0",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      defaults = {
        path_display = { "smart" },
        prompt_prefix = "   ",
        selection_caret = " ",
        entry_prefix = " ",
        sorting_strategy = "ascending",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
          },
          width = 0.87,
          height = 0.80,
        },
        mappings = mappings.telescope(),
      },
      pickers = {
        oldfiles = {
          only_cwd = true,
        },
      },
    },
    config = function(_, opts)
      require("telescope").setup(opts)
      require("config.mappings").telescope()
    end,
  },
  {
    "ggandor/leap.nvim",
    dependencies = "tpope/vim-repeat",
    config = function()
      require("config.mappings").leap()
    end,
  },
  {
    "echasnovski/mini.nvim",
    main = "mini.ai",
    config = true,
  },
  -- Surround text with pairs (quotes, brackets, etc.)
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = true,
  },
  -- Auto-close pairs like brackets and quotes
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },
  -- Auto-tag HTML and XML elements
  {
    "windwp/nvim-ts-autotag",
    name = "nvim-ts-autotag",
    opts = {
      opts = {
        enable_close = true,
        enable_rename = true,
        enable_close_on_slash = true,
      },
    },
  },

  -- Snippet engine and snippets library
  {
    "mbbill/undotree",
  },
  -- Better operate text pairs like quotes, brackets, functions, tags etc
  {
    "andymass/vim-matchup",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
}
