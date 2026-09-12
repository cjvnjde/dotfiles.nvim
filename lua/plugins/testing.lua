local M = {}
local tests, coverage_plugin

function M.neotest()
  if not tests then
    vim.cmd.packadd "nvim-nio"
    vim.cmd.packadd "neotest-vitest"
    vim.cmd.packadd "neotest"
    local plugin = require "neotest"
    plugin.setup {
      discovery = { enabled = false },
      adapters = { require "neotest-vitest" },
    }
    tests = plugin
  end
  return tests
end

function M.coverage()
  if not coverage_plugin then
    vim.cmd.packadd "nvim-coverage"
    local plugin = require "coverage"
    plugin.setup { auto_reload = true }
    coverage_plugin = plugin
  end
  return coverage_plugin
end

local group = vim.api.nvim_create_augroup("TestToolActivation", { clear = true })
vim.api.nvim_create_autocmd("CmdUndefined", {
  group = group,
  pattern = "Neotest",
  once = true,
  callback = M.neotest,
})
vim.api.nvim_create_autocmd("CmdUndefined", {
  group = group,
  pattern = "Coverage*",
  once = true,
  callback = M.coverage,
})

return M
