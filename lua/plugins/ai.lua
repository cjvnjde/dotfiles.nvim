return {
  {
    "github/copilot.vim",
  },
  {
    "cjvnjde/ai-commit.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    opts = {
      model = "google/gemini-2.0-flash-001",
      ignored_files = {
        "package-lock.json",
        "yarn.lock",
        "pnpm-lock.yaml",
      },
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
