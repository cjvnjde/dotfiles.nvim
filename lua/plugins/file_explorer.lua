return {
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    opts = {
      filters = {
        dotfiles = false,
        custom = { "node_modules", "dist", "build", "\\.git" },
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
      require("mappings").nvimtree()
    end,
  },
  {
    "stevearc/oil.nvim",
    config = function()
      require("oil").setup()
      require("mappings").oil()
    end,
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
}
