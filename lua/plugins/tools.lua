local M = {}

require("mason").setup()
require("mason-tool-installer").setup {
  ensure_installed = require "config.mason_packages",
  run_on_start = false, -- Provision explicitly with :MasonToolsInstall / :MasonToolsUpdate.
}
require("which-key").setup()

-- Dadbod's commands and SQL completion already use Vim's native autoload.
vim.g.db_ui_use_nerd_fonts = 1

local http
function M.kulala()
  if not http then
    vim.cmd.packadd "kulala.nvim"
    local plugin = require "kulala"
    plugin.setup(require("config.mappings").kulala)
    http = plugin
  end
  return http
end

local group = vim.api.nvim_create_augroup("HttpActivation", { clear = true })
vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
  group = group,
  pattern = { "*.http", "*.rest" },
  once = true,
  callback = M.kulala,
})
vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = { "http", "rest" },
  once = true,
  callback = function(event)
    if not http then
      M.kulala()
      -- Include newly registered HTTP handlers when a scratch buffer changes filetype.
      vim.api.nvim_exec_autocmds("FileType", { buffer = event.buf, modeline = false })
    end
  end,
})

return M
