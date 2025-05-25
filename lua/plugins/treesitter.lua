local extensions = require "config.extensions"

return {
  -- Treesitter for enhanced syntax highlighting and indentation
  {
    "nvim-treesitter/nvim-treesitter",
    main = "nvim-treesitter.configs",
    opts = {
      ensure_installed = extensions.treesitter,
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
      matchup = {
        enable = true, -- mandatory, false will disable the whole extension
      },
    },
  },
  {
    "andymass/vim-matchup",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
}
