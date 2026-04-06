local mappings = require "config.mappings"
local nesting_rules = require "config.file_nesting_rules"

-- Catppuccin {{{1
-- Colorscheme configuration.
vim.pack.add {
  {
    src = "https://github.com/catppuccin/nvim",
    name = "catppuccin",
  },
}

require("catppuccin").setup {
  flavour = "mocha",
  transparent_background = false,
}

vim.cmd.colorscheme "catppuccin"
-- }}}

-- Lualine {{{1
-- Configure the statusline.
vim.pack.add {
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/nvim-lualine/lualine.nvim",
}

require("lualine").setup {
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = {
      "filename",
      "filetype",
    },
    lualine_x = {
      {
        "rest",
        icon = "",
        fg = "#428890",
      },
      "encoding",
      "fileformat",
    },
  },
}
-- }}}

-- Indent Blankline {{{1
-- Add vertical indentation guides.
vim.pack.add {
  "https://github.com/lukas-reineke/indent-blankline.nvim",
}

require("ibl").setup()
-- }}}

-- Todo Comments {{{1
-- Highlight and search TODO, FIXME, and similar comments.
vim.pack.add {
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/folke/todo-comments.nvim",
}

require("todo-comments").setup()
-- }}}

-- Fidget {{{1
-- LSP progress notifications.
vim.pack.add {
  "https://github.com/j-hui/fidget.nvim",
}

require("fidget").setup {
  notification = {
    window = { winblend = 0 },
  },
}
-- }}}

-- vim: set fdm=marker fdl=0 fen:
