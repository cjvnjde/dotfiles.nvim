-- Telescope {{{1
-- Fuzzy finder for files, buffers, grep, and more.

require("telescope").setup {
  defaults = {
    path_display = { "smart" },
    prompt_prefix = "   ",
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
  },
  pickers = {
    oldfiles = {
      only_cwd = true,
    },
  },
}
-- }}}
-- Mini {{{1
-- Collection of small editing helpers.
require("mini.ai").setup()
require("mini.surround").setup()
require("mini.pairs").setup()
-- }}}

-- Autotag {{{1
-- Auto-tag HTML and XML elements.
require("nvim-ts-autotag").setup {
  opts = {
    enable_close_on_slash = true,
  },
}
-- }}}

-- Gitsigns {{{1
-- Git change indicators and hunk operations.
require("gitsigns").setup {
  current_line_blame = true,
  on_attach = require("config.mappings").gitsigns,
}
-- }}}

-- Neo-tree {{{1
-- File explorer tree.
require("neo-tree").setup {
  popup_border_style = "",
  nesting_rules = require "config.file_nesting_rules",
}
-- }}}

-- vim: set fdm=marker fdl=0 fen:
