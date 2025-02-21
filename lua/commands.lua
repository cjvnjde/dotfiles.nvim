-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "json",
  callback = function(ev)
    vim.bo[ev.buf].formatprg = "jq"
  end,
})

-- remove unused imports in ts and tsx files --
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = vim.api.nvim_create_augroup("ts_imports", { clear = true }),
  pattern = { "*.tsx,*.ts" },
  callback = function()
    vim.lsp.buf.code_action {
      apply = true,
      context = {
        only = { "source.removeUnused.ts" },
        diagnostics = {},
      },
    }
  end,
})

-- Close nvimtree when no other buffer is open --
-- vim.api.nvim_create_autocmd("BufEnter", {
--   group = vim.api.nvim_create_augroup("Neotree", { clear = true }),
--   pattern = "neo-tree",
--   callback = function()
--     local layout = vim.api.nvim_call_function("winlayout", {})
--     if
--       layout[1] == "leaf"
--       and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(layout[2]), "filetype") == "neo-tree"
--       and layout[3] == nil
--     then
--       vim.cmd "confirm quit"
--     end
--   end,
-- })
