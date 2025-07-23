return {
  {
    "supermaven-inc/supermaven-nvim",
    config = true,
  },
  {
    "cjvnjde/ai-commit.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    opts = {
      env = {
        api_key = os.getenv "OPENROUTER_API_KEY",
        url = "https://openrouter.ai/api",
        chat_url = "/v1/chat/completions",
      },
      model = "google/gemini-2.5-flash",
      ignored_files = {
        "package-lock.json",
        "yarn.lock",
        "pnpm-lock.yaml",
        "lazy-lock.json",
      },
    },
  },
}
