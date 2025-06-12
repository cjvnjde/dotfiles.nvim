local mappings = require "config.mappings"
local nesting_rules = require "config.file_nesting_rules"

return {
  -- {
  --   "nvim-tree/nvim-tree.lua",
  --   lazy = false,
  --   cmd = { "NvimTreeToggle", "NvimTreeFocus" },
  --   opts = {
  --     filters = {
  --       dotfiles = false,
  --       custom = { "node_modules", "dist", "^build$", "\\.git" },
  --     },
  --     update_focused_file = {
  --       enable = true,
  --       update_root = false,
  --     },
  --     disable_netrw = true,
  --     hijack_cursor = true,
  --     sync_root_with_cwd = true,
  --     view = {
  --       adaptive_size = true,
  --     },
  --     git = {
  --       ignore = true,
  --     },
  --     renderer = {
  --       root_folder_label = false,
  --       indent_markers = {
  --         enable = true,
  --       },
  --     },
  --   },
  --   config = function(_, opts)
  --     require("nvim-tree").setup(opts)
  --     mappings.nvimtree()
  --   end,
  -- },
  {
    "antosha417/nvim-lsp-file-operations",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-tree.lua",
    },
    config = function()
      require("lsp-file-operations").setup()
    end,
  },
  {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    lazy = false, -- neo-tree will lazily load itself
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
