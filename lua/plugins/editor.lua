local nesting_rules = require "config.file_nesting_rules"
local mappings = require "config.mappings"

-- Telescope {{{1
-- Fuzzy finder for files, buffers, grep, and more.
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
-- }}}

-- Leap {{{1
-- Quick cursor jumping with s and S.
vim.pack.add {
  "https://github.com/tpope/vim-repeat",
  "https://codeberg.org/andyg/leap.nvim",
}

mappings.leap()
-- }}}

-- Mini {{{1
-- Collection of small editing helpers.
vim.pack.add {
  "https://github.com/echasnovski/mini.nvim",
}

require("mini.ai").setup()
require("mini.surround").setup()
require("mini.comment").setup()
require("mini.pairs").setup()
-- }}}

-- Autotag {{{1
-- Auto-tag HTML and XML elements.
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
-- }}}

-- Vim Matchup {{{1
-- Better text-object and pair matching for brackets, tags, and more.
vim.pack.add {
  "https://github.com/andymass/vim-matchup",
}
-- }}}

-- Gitsigns {{{1
-- Git change indicators and hunk operations.
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
-- }}}

--z Neo-tree {{{1
-- File explorer tree.
vim.pack.add {
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/MunifTanjim/nui.nvim",
  {
    src = "https://github.com/nvim-neo-tree/neo-tree.nvim",
    version = "v3.x",
  },
}

require("neo-tree").setup {
  popup_border_style = "",
  nesting_rules = nesting_rules,
}

mappings.neotree()
-- }}}

-- vim: set fdm=marker fdl=0 fen:
