local mappings = require "config.mappings"

-- Telescope START
-- Fuzzy finder for files, buffers, grep, etc
vim.pack.add {
  "https://github.com/nvim-lua/plenary.nvim",
  {
    src = "https://github.com/nvim-telescope/telescope.nvim",
    version = "v0.2.0",
  },
}

require("telescope").setup {
  defaults = {
    path_display = { "smart" },
    prompt_prefix = "   ",
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
  },
  pickers = {
    oldfiles = {
      only_cwd = true,
    },
  },
}

mappings.telescope()
-- Telescope END

-- Leap START
-- Quick cursor jumping with s/S
vim.pack.add {
  "https://github.com/tpope/vim-repeat",
  "https://codeberg.org/andyg/leap.nvim",
}

mappings.leap()
-- Leap END

-- Mini START
-- Collection of small useful modules (ai, surround, comment, pairs)
vim.pack.add {
  "https://github.com/echasnovski/mini.nvim",
}

require("mini.ai").setup()
require("mini.surround").setup()
require("mini.comment").setup()
require("mini.pairs").setup()
-- Mini END

-- Autotag START
-- Auto-tag HTML and XML elements
vim.pack.add {
  "https://github.com/windwp/nvim-ts-autotag",
}

require("nvim-ts-autotag").setup {
  opts = {
    enable_close = true,
    enable_rename = true,
    enable_close_on_slash = true,
  },
}
-- Autotag END

-- Undotree START
-- Visualize and navigate undo history
vim.pack.add {
  "https://github.com/mbbill/undotree",
}
-- Undotree END

-- Vim Matchup START
-- Better operate text pairs like quotes, brackets, functions, tags
vim.pack.add {
  "https://github.com/andymass/vim-matchup",
}
-- Vim Matchup END

-- Gitsigns START
-- Git change indicators and hunk operations
vim.pack.add {
  "https://github.com/lewis6991/gitsigns.nvim",
}

require("gitsigns").setup {
  current_line_blame = true,
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns
    mappings.gitsigns(gs, bufnr)
  end,
}
-- Gitsigns END
