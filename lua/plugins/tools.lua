local extensions = require "config.extensions"

vim.g.db_ui_use_nerd_fonts = 1

local default_ai_model = "x-ai/grok-code-fast-1"

return {
  -- Tool installer for LSP, linters, and formatters
  {
    "williamboman/mason.nvim",
    config = true,
  },

  -- Auto-install tools using Mason
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = extensions.mason,
      run_on_start = true,
    },
    dependencies = { { "williamboman/mason.nvim", config = true } },
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = function()
      local mappings = require "config.mappings"

      return {
        current_line_blame = true,
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
          mappings.gitsigns(gs, bufnr)
        end,
      }
    end,
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "marilari88/neotest-vitest",
      "cjvnjde/neotest-jest",
    },
    config = function()
      require("neotest").setup {
        discovery = {
          enabled = false,
        },
        adapters = {
          require "neotest-vitest",
          require "neotest-jest",
        },
      }
      require("config.mappings").neotest()
    end,
  },
  {
    "andythigpen/nvim-coverage",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      auto_reload = true,
    },
    config = function(_, opts)
      require("coverage").setup(opts)
      require("config.mappings").coverage()
    end,
  },
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql" }, lazy = true },
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
  },
  {
    "mistweaverco/kulala.nvim",
    keys = {
      { "<leader>Rs", desc = "Send request" },
      { "<leader>Ra", desc = "Send all requests" },
      { "<leader>Rb", desc = "Open scratchpad" },
    },
    ft = { "http", "rest" },
    opts = {
      global_keymaps = false,
      global_keymaps_prefix = "<leader>R",
      kulala_keymaps_prefix = "",
    },
  },
  {
    "cjvnjde/ai-commit.nvim",
    -- dir = "/ai-commit.nvim",
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
      model = default_ai_model,
      ignored_files = {
        "package-lock.json",
        "yarn.lock",
        "pnpm-lock.yaml",
        "lazy-lock.json",
      },
      -- debug = true,
    },
  },

  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "ravitemer/mcphub.nvim",
    },
    opts = {
      opts = {
        log_level = "DEBUG",
      },
      display = {
        diff = {
          enabled = true,
          provider = "split",
        },
      },
      adapters = {
        http = {
          openrouter = function()
            return require("codecompanion.adapters").extend("openai_compatible", {
              env = {
                url = "https://openrouter.ai/api",
                api_key = os.getenv "OPENROUTER_API_KEY",
                chat_url = "/v1/chat/completions",
              },
              schema = {
                model = {
                  default = default_ai_model,
                },
              },
            })
          end,
        },
      },
      interactions = {
        chat = {
          adapter = "openrouter",
        },
        inline = {
          adapter = {
            name = "openrouter",
            model = "x-ai/grok-code-fast-1",
          },
        },
        cmd = {
          adapter = "openrouter",
        },
        background = {
          adapter = "openrouter",
        },
      },
    },
  },
}
