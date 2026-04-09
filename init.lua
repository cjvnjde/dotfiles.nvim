require "options"
require "autocmds"
require "lsp"
require "plugins/coding"
require "plugins/editor"
require "plugins/tools"
require "plugins/testing"
require "plugins/experimental"
require "plugins/ui"

require("config.pack").setup()

local mappings = require "config.mappings"

vim.schedule(function()
  mappings.global()
end)

vim.diagnostic.config {
  virtual_text = true,
  underline = true,
  update_in_insert = true,
  virtual_lines = false,
  signs = true,
  float = {
    border = "rounded",
    source = true,
  },
  severity_sort = true,
}

vim.api.nvim_create_user_command("RestartWithSession", function()
  local session_dir = vim.fn.stdpath "state" .. "/sessions"

  if vim.fn.isdirectory(session_dir) == 0 then
    vim.fn.mkdir(session_dir, "p")
  end

  local cwd = vim.fn.getcwd()
  local session_name = cwd:gsub("[\\/]", "%%") .. "_restart.vim"
  local session_path = session_dir .. "/" .. session_name

  local escaped_path = vim.fn.fnameescape(session_path)

  local cmd = string.format("mksession! %s | restart source %s", escaped_path, escaped_path)
  vim.cmd(cmd)
end, { nargs = 0 })
