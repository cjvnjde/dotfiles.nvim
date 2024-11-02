local cmp = require "cmp"
local mappings = require "mappings"

local options = {
  completion = { completeopt = "menu,menuone,noinsert" },
  mapping = mappings.cmp(cmp),
  sources = {
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "luasnip" },
    { name = "path" },
  },
}

cmp.setup(options)

cmp.setup.filetype({ "sql" }, {
  sources = {
    { name = "vim-dadbod-completion" },
    { name = "buffer" },
  },
})
