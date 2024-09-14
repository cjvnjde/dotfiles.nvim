require "options" -- should be first
require "configs.lazy"
require "autocmds"

vim.schedule(function()
  require "mappings"
end)
