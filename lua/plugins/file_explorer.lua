local mappings = require "config.mappings"
local nesting_rules = require "config.file_nesting_rules"

return {
  {
    "antosha417/nvim-lsp-file-operations",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-neo-tree/neo-tree.nvim",
    },
    config = function()
      require("lsp-file-operations").setup()
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    lazy = false,
    ---@module "neo-tree"
    ---@type neotree.Config?
    opts = {
      popup_border_style = "",
      nesting_rules = nesting_rules,
    },
    config = function(_, opts)
      require("neo-tree").setup(opts)
      mappings.neotree()
    end,
  },
}
