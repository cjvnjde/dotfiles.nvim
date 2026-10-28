-- Machine configuration can run code now and return before_init/after_init hooks.
local machine = {}
local local_file = vim.fn.stdpath("config") .. "/init.local.lua"
if vim.uv.fs_stat(local_file) then
  machine = dofile(local_file) or {}
  assert(type(machine) == "table", "init.local.lua must return a table or nil")
end
if machine.before_init then
  machine.before_init()
end

local mappings = require "config.mappings"

require "options"
require "autocmds"
require("config.pack").setup()

require "plugins.editor"
require "plugins.tools"
require "plugins.coding"
require "plugins.testing"
require "plugins.ui"

require "lsp"

mappings.setup()

if machine.after_init then
  machine.after_init()
end
