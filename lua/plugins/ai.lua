local commit_prompt_template = [[
Analyze the following git diff and recent commit history. Generate multiple alternative git commit messages using the Conventional Commits format (type(scope): concise description).

Requirements:
  Each message should cover all significant changes in the diff as a single commit.
  Use a single type and scope per message (feat, fix, refactor, style, test, etc.).
  The subject line must state what was changed, not why.
  Optionally, add a body with more detail if the subject alone is not sufficient—keep it concise and relevant.
  Output only the commit messages (with bodies if needed), no extra text, no explanations, no quotes—one per message.

Input:
Git diff:
%s
Recent commits:
%s
]]

return {
  {
    "github/copilot.vim",
  },
  {
    "cjvnjde/ai-commit.nvim",
    branch = "main",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    opts = {
      model = "google/gemini-2.0-flash-001",
      commit_prompt_template = commit_prompt_template,
    },
  },
}
