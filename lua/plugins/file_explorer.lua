return {
  {
    "stevearc/oil.nvim",
    config = function()
      require("oil").setup()
      require("mappings").oil()
    end,
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      close_if_last_window = true,
      filesystem = {
        follow_current_file = {
          enabled = true,
        },
      },
      nesting_rules = {
        ["ts"] = {
          pattern = "(.*)%.ts$",
          files = { "%1.test.ts", "%1.spec.ts" },
        },
        ["js"] = {
          pattern = "(.*)%.js$",
          files = { "%1.test.js", "%1.spec.js", "%1.module.js" },
        },
        ["css"] = {
          pattern = "(.*)%.css$",
          files = { "%1.module.css", "%1.min.css" },
        },
        ["scss"] = {
          pattern = "(.*)%.scss$",
          files = { "%1.module.scss", "%1.min.scss" },
        },
        ["html"] = {
          pattern = "(.*)%.html$",
          files = { "%1.css", "%1.js", "%1.ts" },
        },
      },
    },
    config = function(_, opts)
      require("neo-tree").setup(opts)
      require("mappings").neotree()
    end,
  },
}
