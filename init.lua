require "options" -- should be first
require "package_manager"
require "commands"
local mappings = require "mappings"

vim.schedule(function()
  mappings.global()
end)
