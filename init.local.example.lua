-- Copy to init.local.lua. This file is private to this checkout and gitignored.
-- Top-level code runs before the shared config. Both hooks are optional.
return {
  before_init = function()
    -- Set globals or environment needed before shared plugins initialize.
    -- vim.g.python3_host_prog = "/path/to/python"
  end,
  after_init = function()
    -- Override options, mappings, plugins, themes, or add autocommands here.
    -- vim.opt.spelllang = { "en", "uk" }
    -- vim.keymap.set("n", "<leader>m", "<cmd>messages<cr>")
    -- vim.pack.add { "https://github.com/owner/plugin" }
  end,
}
