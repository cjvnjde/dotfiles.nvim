return {
  {
    "cjvnjde/ai-split-commit.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "ai-provider.nvim",
      "cjvnjde/ai-commit.nvim",
      "cjvnjde/ai-provider.nvim",
    },
    opts = {
      provider = "github-copilot",
      model = "gpt-5-mini",
      default_view_mode = "group_diff",
    },
  },
}
