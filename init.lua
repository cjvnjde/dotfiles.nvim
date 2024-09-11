require "options" -- should be first
require "configs.lazy"

vim.schedule(function()
  require "mappings"
end)
