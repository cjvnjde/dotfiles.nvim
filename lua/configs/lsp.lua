local lspconfig = require "lspconfig"
local ensure_installed = require "lua.packages"

local map = vim.keymap.set

local on_attach = function(_, bufnr)
  local function opts(desc)
    return { buffer = bufnr, desc = "LSP " .. desc }
  end

  map("n", "gd", vim.lsp.buf.definition, opts "[G]o to [D]efinition")
  map("n", "gi", vim.lsp.buf.implementation, opts "[G]o to [I]mplementation")
  map("n", "<leader>rn", vim.lsp.buf.rename, opts "[R]e[N]ame")
  map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts "[C]ode [A]ction")
end

local on_init = function(client, _)
  if client.supports_method "textDocument/semanticTokens" then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.workspace.fileOperations = {
  dynamicRegistration = false,
  didRename = true,
  willRename = true,
}
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

local lsp_configs = {
  eslint = {
    on_attach = function(_, bufnr)
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        command = "EslintFixAll",
      })
    end,
  },
  lua_ls = {
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT",
        },
        diagnostics = {
          globals = {
            "vim",
            "require",
          },
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
        },
        telemetry = {
          enable = false,
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

  lspconfig[lsp].setup(config)
end

for _, lsp in ipairs(ensure_installed.lsp) do
  setup_lsp(lsp)
end
