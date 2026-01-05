require "config.options" -- should be first
require "config.lazy"
require "config.autocmds"
require "config.typehint_autocmd"
require "config.commands"

local mappings = require "config.mappings"

vim.lsp.enable {
  -- mason
  -- npm i -g bash-language-server
  "bashls",
  -- mason
  -- cargo install codebook-lsp
  "codebook",
  -- mason
  -- npm i -g vscode-langservers-extracted
  "cssls",
  -- mason
  -- npm install -g @olrtg/emmet-language-server
  "emmet_language_server",
  -- mason
  -- npm i -g vscode-langservers-extracted
  "eslint",
  -- mason
  -- npm i -g vscode-langservers-extracted
  "html",
  -- mason
  -- npm i -g vscode-langservers-extracted
  "jsonls",
  -- mason
  -- brew install lua-language-server
  "lua_ls",
  -- pip install python-lsp-server
  -- mason
  -- "pylsp",
  -- mason
  -- "rust_analyzer",
  -- npm install -g svelte-language-server
  "svelte",
  -- mason
  -- npm install -g @tailwindcss/language-server
  "tailwindcss",
  -- mason
  -- npm install -g typescript typescript-language-server
  "ts_ls",
}

vim.lsp.config("cssls", {
  settings = {
    css = {
      lint = {
        unknownAtRules = "ignore",
      },
    },
  },
})

vim.lsp.config("eslint", {
  settings = {
    experimental = {
      useFlatConfig = true,
    },
  },
})

vim.lsp.config("lua_ls", {
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
})

vim.lsp.config("tailwindcss", {
  settings = {
    tailwindCSS = {
      experimental = {
        classRegex = {
          { "clsx\\(.*?\\)(?!\\])", "(?:'|\"|`)([^\"'`]*)(?:'|\"|`)" },
          "(?:enter|leave)(?:From|To)?=\\s*(?:\"|'|{`)([^(?:\"|'|`})]*)",
          { "(?:twMerge|twJoin)\\(([^;]*)[\\);]", "[`'\"`]([^'\"`;]*)[`'\"`]" },
          { "tv\\({([^]*?)}\\)", "[\"'`]([^\"'`]*)[\"'`]" },
        },
      },
    },
  },
})

local js_ts_default_settings = {
  inlayHints = {
    includeInlayEnumMemberValueHints = true,
    includeInlayFunctionLikeReturnTypeHints = true,
    includeInlayFunctionParameterTypeHints = true,
    includeInlayParameterNameHints = "all",
    includeInlayParameterNameHintsWhenArgumentMatchesName = true,
    includeInlayPropertyDeclarationTypeHints = true,
    includeInlayVariableTypeHints = true,
  },
}
vim.lsp.config("ts_ls", {
  settings = {
    typescript = js_ts_default_settings,
    javascript = js_ts_default_settings,
  },
})

vim.schedule(function()
  mappings.global()
end)

vim.diagnostic.config {
  virtual_text = true,
  underline = true,
  update_in_insert = true,
  virtual_lines = false,
  signs = true,
  float = {
    border = "rounded",
    source = true,
  },
  severity_sort = true,
}
