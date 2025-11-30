return {
  -- Theme configuration
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    lazy = false,
    opts = {
      flavour = "mocha",
      transparent_background = true,
    },
    config = function(self, opts)
      require(self.name).setup(opts)
      vim.cmd.colorscheme "catppuccin"
    end,
  },
  -- Status line configuration
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
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
            icon = "",
            fg = "#428890",
          },
          "encoding",
          "fileformat",
        },
        lualine_z = { "location" },
      },
    },
  },
  -- Add vertical indentation lines
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = true,
  },
  -- Display keybindings in a popup
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    cmd = "WhichKey",
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = true,
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "codecompanion" },
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    opts = {
      max_lines = 5,
    },
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "%d+L, %d+B" },
              { find = "; after #%d+" },
              { find = "; before #%d+" },
            },
          },
          view = "mini",
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  },
  {
    "rcarriga/nvim-notify",
    opts = {
      background_colour = "#000000",
    },
  },
}
