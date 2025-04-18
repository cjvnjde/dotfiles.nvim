return {
  -- {
  --   "stevearc/oil.nvim",
  --   config = function()
  --     require("oil").setup()
  --     require("config.mappings").oil()
  --   end,
  --   dependencies = { "nvim-tree/nvim-web-devicons" },
  -- },
  {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    opts = {
      filters = {
        dotfiles = false,
        custom = { "node_modules", "dist", "^build$", "\\.git" },
      },
      update_focused_file = {
        enable = true,
        update_root = false,
      },
      disable_netrw = true,
      hijack_cursor = true,
      sync_root_with_cwd = true,
      view = {
        adaptive_size = true,
      },
      git = {
        ignore = true,
      },
      renderer = {
        root_folder_label = false,
        indent_markers = {
          enable = true,
        },
      },
    },
    config = function(_, opts)
      require("nvim-tree").setup(opts)
      require("config.mappings").nvimtree()
    end,
  },
  {
    "antosha417/nvim-lsp-file-operations",
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- Uncomment whichever supported plugin(s) you use
      "nvim-tree/nvim-tree.lua",
      -- "nvim-neo-tree/neo-tree.nvim",
      -- "simonmclean/triptych.nvim"
    },
    config = function()
      require("lsp-file-operations").setup()
    end,
  },
  -- {
  --   "nvim-neo-tree/neo-tree.nvim",
  --   branch = "v3.x",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-tree/nvim-web-devicons",
  --     "MunifTanjim/nui.nvim",
  --   },
  --   opts = {
  --     close_if_last_window = true,
  --     filesystem = {
  --       follow_current_file = {
  --         enabled = true,
  --       },
  --     },
  --     nesting_rules = {
  --       ["ts"] = {
  --         pattern = "(.*)%.ts$",
  --         files = { "%1.test.ts", "%1.spec.ts" },
  --       },
  --       ["js"] = {
  --         pattern = "(.*)%.js$",
  --         files = { "%1.test.js", "%1.spec.js", "%1.module.js" },
  --       },
  --       ["css"] = {
  --         pattern = "(.*)%.css$",
  --         files = { "%1.module.css", "%1.min.css" },
  --       },
  --       ["scss"] = {
  --         pattern = "(.*)%.scss$",
  --         files = { "%1.module.scss", "%1.min.scss" },
  --       },
  --       ["html"] = {
  --         pattern = "(.*)%.html$",
  --         files = { "%1.css", "%1.js", "%1.ts" },
  --       },
  --     },
  --   },
  --   config = function(_, opts)
  --     require("neo-tree").setup(opts)
  --     require("config.mappings").neotree()
  --   end,
  -- },
}
