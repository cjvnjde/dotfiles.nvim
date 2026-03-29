return {
  {
    "cjvnjde/ai-split-commit.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "cjvnjde/ai-provider.nvim",
      "cjvnjde/ai-commit.nvim",
    },
    opts = {
      provider = "github-copilot",
      model = "gpt-5-mini",
      ai_options = {
        reasoning = "high",
      },
      default_view_mode = "group_diff",
    },
  },
}
