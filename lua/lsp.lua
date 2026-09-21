local enabled_servers = {
  "bashls",
  "codebook",
  "cssls",
  "emmet_language_server",
  "eslint",
  -- Godot editor built-in LSP. Requires the Godot editor to be open.
  "gdscript",
  "gopls",
  "html",
  "jsonls",
  "lua_ls",
  "pylsp",
  "svelte",
  "tailwindcss",
  "ts_ls",
}

vim.lsp.config("gdscript", {
  root_markers = { "project.godot" },
})

vim.lsp.config("cssls", {
  settings = {
    css = {
      lint = {
        unknownAtRules = "ignore",
      },
    },
  },
})

vim.lsp.config("lua_ls", {
  on_init = function(client)
    local root = client.root_dir and vim.uv.fs_realpath(client.root_dir)
    -- Resolve both paths: ~/.config/nvim may be a symlink into the dotfiles repo.
    if not root or root ~= vim.uv.fs_realpath(vim.fn.stdpath "config") then
      return
    end
    if vim.uv.fs_stat(root .. "/.luarc.json") or vim.uv.fs_stat(root .. "/.luarc.jsonc") then
      return
    end

    local settings = vim.tbl_deep_extend("force", vim.deepcopy(client.settings), {
      Lua = {
        runtime = {
          version = "LuaJIT",
          path = { "lua/?.lua", "lua/?/init.lua" },
        },
        workspace = {
          checkThirdParty = false,
          library = { vim.env.VIMRUNTIME },
        },
      },
    })
    client.settings = settings
    client.config.settings = settings
    -- Initial settings are sent before on_init; publish the scoped override.
    client:notify("workspace/didChangeConfiguration", { settings = settings })
  end,
})

-- @see https://github.com/paolotiu/tailwind-intellisense-regex-list
vim.lsp.config("tailwindcss", {
  settings = {
    tailwindCSS = {
      experimental = {
        classRegex = {
          { "clsx\\(((?:[^()]|\\([^()]*\\))*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
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

vim.lsp.enable(enabled_servers)
