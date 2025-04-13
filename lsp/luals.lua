return {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { ".luarc.json", ".luarc.jsonc", ".stylua.toml", "lazy-lock.json", ".git" },
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      signatureHelp = { enabled = true },
      hint = {
        enable = true,
      },
      diagnostics = {
        globals = {
          "vim",
          "require",
        },
      },
    },
  },
}
