local extensions = require "config.extensions"
local mappings = require "config.mappings"

local is_log = function(entry)
  return entry.label == "log" and entry.source_name == "Snippets"
end

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
    "saghen/blink.cmp",
    dependencies = { "L3MON4D3/LuaSnip", "Kaiser-Yang/blink-cmp-avante" },
    version = "1.*",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      snippets = { preset = "luasnip" },
      keymap = mappings.blink,
      appearance = {
        nerd_font_variant = "mono",
      },
      completion = {
        documentation = { auto_show = true },
        list = { selection = { preselect = true, auto_insert = false } },
        menu = {
          draw = {
            components = {
              kind_icon = {
                text = function(ctx)
                  local icon = ctx.kind_icon

                  if ctx.item.source_name == "LSP" then
                    local color_item =
                      require("nvim-highlight-colors").format(ctx.item.documentation, { kind = ctx.kind })
                    if color_item and color_item.abbr ~= "" then
                      icon = color_item.abbr
                    end
                  end
                  return icon .. ctx.icon_gap
                end,
                highlight = function(ctx)
                  local highlight = "BlinkCmpKind" .. ctx.kind
                  if ctx.item.source_name == "LSP" then
                    local color_item =
                      require("nvim-highlight-colors").format(ctx.item.documentation, { kind = ctx.kind })
                    if color_item and color_item.abbr_hl_group then
                      highlight = color_item.abbr_hl_group
                    end
                  end
                  return highlight
                end,
              },
            },
          },
        },
      },
      signature = { enabled = true },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },

        per_filetype = {
          codecompanion = { "codecompanion" },
          sql = { "snippets", "dadbod", "buffer" },
        },
        providers = {
          dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
        },
      },
      fuzzy = {
        implementation = "prefer_rust_with_warning",
        sorts = {
          function(a, b)
            if is_log(a) and not is_log(b) then
              return true
            end
            if is_log(b) and not is_log(a) then
              return false
            end
          end,
          "score",
          "sort_text",
        },
      },
    },
    opts_extend = { "sources.default" },
  },

  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    dependencies = "rafamadriz/friendly-snippets",
    config = function()
      -- vscode format
      require("luasnip.loaders.from_vscode").lazy_load { exclude = vim.g.vscode_snippets_exclude or {} }
      require("luasnip.loaders.from_vscode").lazy_load { paths = vim.g.vscode_snippets_path or "" }

      -- snipmate format
      require("luasnip.loaders.from_snipmate").load()
      require("luasnip.loaders.from_snipmate").lazy_load { paths = vim.g.snipmate_snippets_path or "" }

      -- lua format
      require("luasnip.loaders.from_lua").load()
      require("luasnip.loaders.from_lua").lazy_load { paths = vim.g.lua_snippets_path or "" }

      require "snippets"

      vim.api.nvim_create_autocmd("InsertLeave", {
        callback = function()
          if
            require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
            and not require("luasnip").session.jump_active
          then
            require("luasnip").unlink_current()
          end
        end,
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = extensions.treesitter,
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
      matchup = {
        enable = true, -- mandatory, false will disable the whole extension
      },
    },
  },
  -- Automatically detect and set tab width
  "tpope/vim-sleuth",

  -- Auto-format files on save
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = {
      formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        svelte = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        jsonc = { "prettier" },
        yaml = { "prettier" },
        markdown = { "markdownlint" },
        graphql = { "prettier" },
        vue = { "prettier" },
        lua = { "stylua" },
        rust = { "rustfmt" },
        sql = { "sql_formatter" },
      },
      formatters = {
        sql_formatter = {
          args = {
            "--language",
            "postgresql",
            "--config",
            '{"keywordCase":"upper","functionCase":"upper","dataTypeCase":"upper"}',
          },
        },
      },
      format_after_save = {
        lsp_fallback = true,
      },
    },
    config = function(_, opts)
      require("conform").setup(opts)
      require("config.mappings").conform()
    end,
  },
  {
    "antosha417/nvim-lsp-file-operations",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-neo-tree/neo-tree.nvim",
    },
    config = function()
      require("lsp-file-operations").setup()
    end,
  },
  {
    "github/copilot.vim",
  },
}
