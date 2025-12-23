return {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = {
    ".emmyrc.json",
    ".luarc.json",
    ".luarc.jsonc",
    ".luacheckrc",
    ".stylua.toml",
    "stylua.toml",
    "selene.toml",
    "selene.yml",
    ".git",
  },
  settings = {
    Lua = {
      codeLens = { enable = true },
      runtime = {
        version = "LuaJIT",
        path = {
          "?.lua",
          "?/init.lua",
        },
      },
      signatureHelp = { enabled = true },
      hint = {
        enable = true,
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
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
