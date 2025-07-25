local mappings = require "config.mappings"

return {
  -- Fuzzy finder and search tool
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      defaults = {
        path_display = { "smart" },
        prompt_prefix = "   ",
        selection_caret = " ",
        entry_prefix = " ",
        sorting_strategy = "ascending",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
          },
          width = 0.87,
          height = 0.80,
        },
        mappings = mappings.telescope(),
      },
    },
    config = function(_, opts)
      require("telescope").setup(opts)
      require("config.mappings").telescope()
    end,
  },
}
