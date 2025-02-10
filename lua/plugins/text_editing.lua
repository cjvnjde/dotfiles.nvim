return {
  -- Surround text with pairs (quotes, brackets, etc.)
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = true,
  },
  -- Auto-close pairs like brackets and quotes
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },
  -- Auto-tag HTML and XML elements
  {
    "windwp/nvim-ts-autotag",
    name = "nvim-ts-autotag",
    opts = {
      opts = {
        enable_close = true,
        enable_rename = true,
        enable_close_on_slash = true,
      },
    },
  },
}
