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

for _, lsp in ipairs(ensure_installed.lsp) do
  if lsp == "eslint" then
    lspconfig[lsp].setup {
      on_attach = function(_, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          command = "EslintFixAll",
        })
        on_attach(_, bufnr)
      end,
      on_init = on_init,
      capabilities = capabilities,
    }
  else
    lspconfig[lsp].setup {
      on_attach = on_attach,
      on_init = on_init,
      capabilities = capabilities,
    }
  end
end
