local mappings = require "config.mappings"
local nesting_rules = require "config.file_nesting_rules"

-- Catppuccin START
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
-- Catppuccin END

-- Lualine START
-- Configures how the bottom line looks like
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
-- Lualine END

-- Indent Blankline START
-- Add vertical indentation lines
vim.pack.add {
  "https://github.com/lukas-reineke/indent-blankline.nvim",
}

require("ibl").setup()
-- Indent Blankline END

-- Which Key START
-- Display keybindings in a popup
vim.pack.add {
  "https://github.com/folke/which-key.nvim",
}

require("which-key").setup()
-- Which Key END

-- Todo Comments START
-- Highlight and search TODO/FIXME/etc comments
vim.pack.add {
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/folke/todo-comments.nvim",
}

require("todo-comments").setup()
-- Todo Comments END

-- Neo-tree START
-- File explorer tree
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
-- Neo-tree END

-- Fidget START
-- LSP progress notification
vim.pack.add {
  "https://github.com/j-hui/fidget.nvim",
}

require("fidget").setup {
  notification = {
    window = { winblend = 0 },
  },
}
-- Fidget END
