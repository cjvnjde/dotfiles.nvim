require "options" -- should be first
require "configs.lazy"
require "commands"
local mappings = require "mappings"

vim.schedule(function()
  mappings.global()
end)
