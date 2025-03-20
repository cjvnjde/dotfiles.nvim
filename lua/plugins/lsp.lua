local function configure_lsp()
  local extensions = require "extensions"
  local lspconfig = require "lspconfig"
  local mappings = require "mappings"

  local on_attach = function(client, bufnr)
    mappings.lsp(client, bufnr)
  end

  local on_init = function(client, _)
    if client.supports_method "textDocument/semanticTokens" then
      client.server_capabilities.semanticTokensProvider = nil
    end
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = vim.tbl_deep_extend("force", capabilities, require("lsp-file-operations").default_capabilities())

  capabilities.textDocument.completion.completionItem = {
    documentationFormat = { "markdown", "plaintext" },
    snippetSupport = true,
    preselectSupport = true,
    insertReplaceSupport = true,
    labelDetailsSupport = true,
    deprecatedSupport = true,
    commitCharactersSupport = true,
    tagSupport = { valueSet = { 1 } },
    resolveSupport = {
      properties = {
        "documentation",
        "detail",
        "additionalTextEdits",
      },
    },
  }

  local js_ts_default_settings = {
    inlayHints = {
      includeInlayEnumMemberValueHints = true,
      includeInlayFunctionLikeReturnTypeHints = true,
      includeInlayFunctionParameterTypeHints = true,
      includeInlayParameterNameHints = "all",
      includeInlayParameterNameHintsWhenArgumentMatchesName = true,
      includeInlayPropertyDeclarationTypeHints = true,
      includeInlayVariableTypeHints = true,
    },
  }

  local lsp_configs = {
    eslint = {
      on_attach = function(_, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          command = "EslintFixAll",
        })
      end,
    },
    ts_ls = {
      settings = {
        typescript = js_ts_default_settings,
        javascript = js_ts_default_settings,
      },
      init_options = {
        preferences = {
          importModuleSpecifierPreference = "minimal",
          importModuleSpecifierEnding = "minimal",
        },
      },
    },
    lua_ls = {
      settings = {
        Lua = {
          runtime = {
            version = "LuaJIT",
          },
          hint = {
            enable = true,
          },
          diagnostics = {
            globals = {
              "vim",
              "require",
            },
          },
          telemetry = {
            enable = false,
          },
        },
      },
    },
    tailwindcss = {
      settings = {
        tailwindCSS = {
          experimental = {
            classRegex = {
              { "clsx\\(.*?\\)(?!\\])", "(?:'|\"|`)([^\"'`]*)(?:'|\"|`)" },
              "(?:enter|leave)(?:From|To)?=\\s*(?:\"|'|{`)([^(?:\"|'|`})]*)",
              { "(?:twMerge|twJoin)\\(([^;]*)[\\);]", "[`'\"`]([^'\"`;]*)[`'\"`]" },
              { "tv\\(([^)]*)\\)", "{?\\s?[\\w].*:\\s*?[\"'`]([^\"'`]*).*?,?\\s?}?" },
            },
          },
        },
      },
    },
  }

  local function setup_lsp(lsp)
    local config = {
      on_attach = function(client, bufnr)
        if lsp_configs[lsp] and lsp_configs[lsp].on_attach then
          lsp_configs[lsp].on_attach(client, bufnr)
        end

        on_attach(client, bufnr)
      end,
      on_init = on_init,
      capabilities = capabilities,
    }

    if lsp_configs[lsp] and lsp_configs[lsp].settings then
      config.settings = lsp_configs[lsp].settings
    end

    if lsp_configs[lsp] and lsp_configs[lsp].init_options then
      config.init_options = lsp_configs[lsp].init_options
    end

    lspconfig[lsp].setup(config)
  end

  for _, lsp in ipairs(extensions.lsp) do
    setup_lsp(lsp)
  end
end

return {
  -- LSP configuration
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim", config = true },
      {
        "j-hui/fidget.nvim",
        opts = {
          progress = {
            ignore = {
              function(msg)
                return msg.lsp_client.name == "pylsp" and string.find(msg.title, "lint:")
              end,
            },
          },
        },
      },
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      configure_lsp()
    end,
  },
  -- File operations support with LSP
  {
    "antosha417/nvim-lsp-file-operations",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-tree.lua",
    },
    opts = {
      operations = {
        willRenameFiles = true,
        didRenameFiles = true,
        willCreateFiles = true,
        didCreateFiles = true,
        willDeleteFiles = true,
        didDeleteFiles = true,
      },
    },
  },
}
