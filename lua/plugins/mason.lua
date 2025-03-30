local extensions = require "config.extensions"

return {
  -- Tool installer for LSP, linters, and formatters
  {
    "williamboman/mason.nvim",
    config = true,
  },

  -- Auto-install tools using Mason
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = extensions.mason,
      run_on_start = true,
    },
    dependencies = { { "williamboman/mason.nvim", config = true } },
  },
}
