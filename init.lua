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
