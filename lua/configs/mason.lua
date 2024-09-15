local ensure_installed = require "packages"

local M = {
  mason_auto_install = {
    ensure_installed = ensure_installed.mason,
    run_on_start = true,
  },
}

return M
