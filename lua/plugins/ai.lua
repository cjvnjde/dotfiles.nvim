-- Trust me bro, I know what I'm doing
vim.g.codecompanion_auto_tool_mode = true
vim.g.mcphub_auto_approve = true

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
      env = {
        api_key = os.getenv "OPENROUTER_API_KEY",
        url = "https://openrouter.ai/api",
        chat_url = "/v1/chat/completions",
      },
      model = "google/gemini-2.5-flash-preview-05-20",
      ignored_files = {
        "package-lock.json",
        "yarn.lock",
        "pnpm-lock.yaml",
        "lazy-lock.json",
      },
    },
  },
  {
    "olimorris/codecompanion.nvim",
    opts = {
      adapters = {
        opts = {
          show_model_choices = false,
        },
        openrouter = function()
          return require("codecompanion.adapters").extend("openai_compatible", {
            env = {
              api_key = os.getenv "OPENROUTER_API_KEY",
              url = "https://openrouter.ai/api",
              chat_url = "/v1/chat/completions",
            },
            schema = {
              model = {
                default = "google/gemini-2.5-pro-preview",
              },
            },
          })
        end,
      },
      extensions = {
        mcphub = {
          callback = "mcphub.extensions.codecompanion",
          opts = {
            show_result_in_chat = true,
            make_vars = true,
            make_slash_commands = true,
          },
        },
      },
      strategies = {
        chat = {
          adapter = "openrouter",
          tools = {
            opts = {
              default_tools = {
                "full_stack_dev",
              },
            },
          },
        },
        inline = {
          adapter = "openrouter",
        },
        cmd = {
          adapter = "openrouter",
        },
      },
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
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
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
