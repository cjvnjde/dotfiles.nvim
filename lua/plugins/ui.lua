require("catppuccin").setup {
  flavour = "mocha",
  transparent_background = true,
}

vim.cmd.colorscheme "catppuccin"

require("lualine").setup {
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = {
      "filename",
      "filetype",
      "lsp_status",
    },
    lualine_x = {
      "encoding",
      "fileformat",
    },
  },
}

require("ibl").setup()

-- Highlight words anywhere in text; no signs, comment-only filtering, or TODO commands.
require("mini.hipatterns").setup {
  highlighters = {
    fixme = {
      pattern = {
        "%f[%w]()FIXME()%f[%W]",
        "%f[%w]()FIX()%f[%W]",
        "%f[%w]()BUG()%f[%W]",
        "%f[%w]()FIXIT()%f[%W]",
        "%f[%w]()ISSUE()%f[%W]",
      },
      group = "MiniHipatternsFixme",
    },
    todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
    hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
    warn = {
      pattern = { "%f[%w]()WARN()%f[%W]", "%f[%w]()WARNING()%f[%W]", "%f[%w]()XXX()%f[%W]" },
      group = "MiniHipatternsHack",
    },
    perf = {
      pattern = {
        "%f[%w]()PERF()%f[%W]",
        "%f[%w]()OPTIM()%f[%W]",
        "%f[%w]()PERFORMANCE()%f[%W]",
        "%f[%w]()OPTIMIZE()%f[%W]",
      },
      group = "MiniHipatternsNote",
    },
    note = {
      pattern = { "%f[%w]()NOTE()%f[%W]", "%f[%w]()INFO()%f[%W]" },
      group = "MiniHipatternsNote",
    },
    test = {
      pattern = {
        "%f[%w]()TEST()%f[%W]",
        "%f[%w]()TESTING()%f[%W]",
        "%f[%w]()PASSED()%f[%W]",
        "%f[%w]()FAILED()%f[%W]",
      },
      group = "MiniHipatternsTodo",
    },
  },
}
