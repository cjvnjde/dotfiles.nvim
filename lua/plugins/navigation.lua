return {
  {
    "ggandor/leap.nvim",
    dependencies = "tpope/vim-repeat",
    config = function()
      require("config.mappings").leap()
    end,
  },
}
