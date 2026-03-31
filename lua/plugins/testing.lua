local mappings = require "config.mappings"

-- Neotest START
-- Test runner framework
vim.pack.add {
  "https://github.com/nvim-neotest/nvim-nio",
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/antoinemadec/FixCursorHold.nvim",
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/marilari88/neotest-vitest",
  "https://github.com/nvim-neotest/neotest",
}

require("neotest").setup {
  discovery = {
    enabled = false,
  },
  adapters = {
    require "neotest-vitest",
  },
}

mappings.neotest()
-- Neotest END

-- Coverage START
-- Display test coverage indicators
vim.pack.add {
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/andythigpen/nvim-coverage",
}

require("coverage").setup {
  auto_reload = true,
}

mappings.coverage()
-- Coverage END
