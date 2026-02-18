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
        file_ignore_patterns = {
          "node_modules",
          "%.lock",
          "lazy%-lock%.json",
          "%.git",
          "build",
          "dist",
          "yarn%.lock",
          "package%-lock%.json",
        },
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
    url = "https://codeberg.org/andyg/leap.nvim",
    dependencies = "tpope/vim-repeat",
    config = function()
      require("config.mappings").leap()
    end,
  },
  {
    "nvim-mini/mini.nvim",
    config = function()
      require("mini.ai").setup()
      require("mini.surround").setup()
      require("mini.comment").setup()
      require("mini.pairs").setup()
    end,
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
  },

  {
    "lewis6991/gitsigns.nvim",
    opts = function()
      local mappings = require "config.mappings"

      return {
        current_line_blame = true,
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
          mappings.gitsigns(gs, bufnr)
        end,
      }
    end,
  },
}
