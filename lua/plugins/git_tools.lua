return {
  -- Git integration
  {
    "lewis6991/gitsigns.nvim",
    opts = function()
      local mappings = require "config.mappings"

      return {
        current_line_blame = true,
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
          mappings.gitsigns(gs, bufnr)
        end,
      }
    end,
  },
  {
    "tpope/vim-fugitive",
  },
}
