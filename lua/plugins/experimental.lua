-- AI Split Commit {{{1
-- Split changes into logical commits with AI.
vim.pack.add {
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/cjvnjde/ai-provider.nvim",
  "https://github.com/cjvnjde/ai-commit.nvim",
  "https://github.com/cjvnjde/ai-split-commit.nvim",
}

require("ai-split-commit").setup {
  provider = "github-copilot",
  model = "gpt-5-mini",
  ai_options = {
    reasoning = "high",
  },
  default_view_mode = "group_diff",
}
-- }}}

-- vim: set fdm=marker fdl=0 fen:
