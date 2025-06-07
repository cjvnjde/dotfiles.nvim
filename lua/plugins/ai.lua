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
  {
    "olimorris/codecompanion.nvim",
    opts = {
      adapters = {
        openrouter = function()
          return require("codecompanion.adapters").extend("openai_compatible", {
            env = {
              api_key = vim.env.OPENROUTER_API_KEY,
              url = "https://openrouter.ai/api",
              chat_url = "/v1/chat/completions",
            },
            schema = {
              model = {
                default = "google/gemini-2.0-flash-001",
              },
            },
          })
        end,
      },
      extensions = {
        mcphub = {
          callback = "mcphub.extensions.codecompanion",
          opts = {
            show_result_in_chat = true, -- Show mcp tool results in chat
            make_vars = true, -- Convert resources to #variables
            make_slash_commands = true, -- Add prompts as /slash commands
          },
        },
      },
      -- strategies = {
      --   chat = {
      --     adapter = "openrouter",
      --   },
      --   inline = {
      --     adapter = "openrouter",
      --   },
      --   cmd = {
      --     adapter = "openrouter",
      --   },
      -- },
    },
    config = true,
    dependencies = {
      "ravitemer/mcphub.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },
  {
    "ravitemer/mcphub.nvim",
    build = "npm install -g mcp-hub@latest",
    config = function()
      require("mcphub").setup {
        auto_approve = true,
        auto_toggle_mcp_servers = true,
      }
    end,
  },
  {
    "HakonHarnes/img-clip.nvim",
    opts = {
      filetypes = {
        codecompanion = {
          prompt_for_file_name = false,
          template = "[Image]($FILE_PATH)",
          use_absolute_path = true,
        },
      },
    },
  },
}
