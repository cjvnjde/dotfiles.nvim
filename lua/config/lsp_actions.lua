local M = {}

function M.toggle_codebook_diagnostics()
  for _, client in ipairs(vim.lsp.get_clients { name = "codebook" }) do
    local ns = vim.lsp.diagnostic.get_namespace(client.id)
    local enabled = not vim.diagnostic.is_enabled { ns_id = ns }
    vim.diagnostic.enable(enabled, { ns_id = ns })
    vim.notify("Codebook diagnostics " .. (enabled and "enabled" or "disabled"))
  end
end

function M.toggle_inlay_hints()
  local bufnr = vim.api.nvim_get_current_buf()
  if #vim.lsp.get_clients { bufnr = bufnr, method = "textDocument/inlayHint" } == 0 then
    vim.notify("No LSP client supports inlay hints for this buffer", vim.log.levels.WARN)
    return
  end
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = bufnr }, { bufnr = bufnr })
end

return M
