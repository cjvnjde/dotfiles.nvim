return {
  -- Autocompletion engine
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
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
    end,
  },
}
