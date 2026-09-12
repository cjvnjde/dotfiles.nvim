local M = {}

local deferred = {
  ["nvim-nio"] = true,
  ["neotest-vitest"] = true,
  neotest = true,
  ["nvim-coverage"] = true,
  ["kulala.nvim"] = true,
}

local plugins = {
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/MunifTanjim/nui.nvim",
  "https://github.com/nvim-tree/nvim-web-devicons",
  { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
  "https://github.com/nvim-mini/mini.nvim",
  "https://github.com/nvim-lualine/lualine.nvim",
  "https://github.com/lukas-reineke/indent-blankline.nvim",
  { src = "https://github.com/nvim-telescope/telescope.nvim", version = "v0.2.1" },
  { src = "https://github.com/nvim-neo-tree/neo-tree.nvim", version = "v3.x" },
  "https://codeberg.org/andyg/leap.nvim",
  "https://github.com/windwp/nvim-ts-autotag",
  "https://github.com/andymass/vim-matchup",
  "https://github.com/tpope/vim-sleuth",
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/rafamadriz/friendly-snippets",
  { src = "https://github.com/saghen/blink.cmp", version = vim.version.range "1" },
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/mks-h/treesitter-autoinstall.nvim",
  "https://github.com/stevearc/conform.nvim",
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/Crysthamus/nvim-file-operations",
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
  "https://github.com/folke/which-key.nvim",
  "https://github.com/tpope/vim-dadbod",
  "https://github.com/kristijanhusak/vim-dadbod-completion",
  "https://github.com/kristijanhusak/vim-dadbod-ui",
  { src = "https://github.com/mistweaverco/kulala.nvim", version = vim.version.range "6" },
  "https://github.com/nvim-neotest/nvim-nio",
  "https://github.com/marilari88/neotest-vitest",
  "https://github.com/nvim-neotest/neotest",
  "https://github.com/andythigpen/nvim-coverage",
}

function M.setup()
  -- Register before the first add: vim.pack installs the whole lockfile at once.
  vim.api.nvim_create_autocmd("PackChanged", {
    group = vim.api.nvim_create_augroup("PackHooks", { clear = true }),
    callback = function(ev)
      local data = ev.data
      if data.spec.name == "nvim-treesitter" and (data.kind == "install" or data.kind == "update") then
        if not data.active then
          vim.cmd.packadd "nvim-treesitter"
        end
        -- Other plugins may install parsers that nvim-treesitter does not manage.
        local treesitter = require "nvim-treesitter"
        treesitter.update(treesitter.get_available())
      end
    end,
  })

  -- Register deferred packages too, so updates do not depend on which tools were used.
  vim.pack.add(plugins, {
    load = function(plugin)
      if not deferred[plugin.spec.name] then
        vim.cmd.packadd { plugin.spec.name, bang = true }
      end
    end,
  })

  vim.api.nvim_create_user_command("PackUpdate", function(opts)
    local active = {}
    for _, plugin in ipairs(vim.pack.get(nil, { info = false })) do
      if plugin.active then
        active[#active + 1] = plugin.spec.name
      end
    end

    if #active == 0 then
      vim.notify "vim.pack: no active plugins to update"
      return
    end

    -- Pruning is explicit via vim.pack.del(); cancelling an update must be safe.
    vim.pack.update(active, { force = opts.bang })
  end, {
    bang = true,
    desc = "Review updates to active vim.pack plugins (! skips review)",
  })
end

return M
