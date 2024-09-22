require "options" -- should be first
require "configs.lazy"
require "autocmds"
local mappings = require "mappings"

vim.schedule(function()
  mappings.global()
end)

local gdproject = io.open(vim.fn.getcwd() .. "/project.godot", "r")
if gdproject then
  io.close(gdproject)
  vim.fn.serverstart "./godothost"
end
