local utils = require "utils"

local M = {}

local map = vim.keymap.set

M.global = function()
  map("n", "<leader>w", function()
    vim.opt.wrap = not vim.opt.wrap:get()
  end, { desc = "Toggle line wrap" })

  -- navigate between windows
  map("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
  map("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
  map("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
  map("n", "<C-k>", "<C-w>k", { desc = "switch window up" })

  -- common
  map("n", "<Esc>", "<cmd>noh<CR>", { desc = "General Clear highlights" })
  map("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

  map("n", "<C-u>", "<C-u>zz", { desc = "Move middle up" })
  map("n", "<C-d>", "<C-d>zz", { desc = "Move middle down" })

  map("v", "<leader>p", '"_dP', { desc = "Paste without yanking" })
  -- map("v", "y", "ygv<Esc>", { desc = "Yank and keep selection" })

  map("v", "<leader>y", '"+y', { desc = "Yank to a clipboard" })
  map("n", "<leader>p", '"+p', { desc = "Paste from a clipboard" })

  map("v", ">", ">gv", { desc = "Indent text" })
  map("v", "<", "<gv", { desc = "Indent text" })

  -- swap ; and : keys
  map("n", ";", ":", { noremap = true, silent = false })
  map("v", ";", ":", { noremap = true, silent = false })

  map("n", ":", ";", { noremap = true, silent = false })
  map("v", ":", ";", { noremap = true, silent = false })

  -- Comment
  map("n", "<leader>/", "gcc", { desc = "Toggle Comment", remap = true })
  map("v", "<leader>/", "gc", { desc = "Toggle comment", remap = true })

  -- Colors
  map("n", "<leader>tc", function()
    local colors = utils.try_require "nvim-highlight-colors"
    if colors then
      colors.toggle()
    else
      vim.notify("nvim-highlight-colors not found", vim.log.levels.WARN)
    end
  end, { desc = "[T]oggle [C]olors" })

  -- Quickfix
  map("n", "<leader>q", ":cclose<CR>", { desc = "[Q]uit quick fix list", silent = true })
  map("n", "<leader>tq", function()
    if utils.is_quickfix_open() then
      return "<cmd>cclose<CR>"
    else
      return "<cmd>copen<CR>"
    end
  end, { expr = true, desc = "[T]oggle [Q]uit quick fix list", silent = true })
  -- Undotree
  map("n", "<leader>u", ":UndotreeToggle<CR>", { desc = "[U]ndo [T]ree" })
end

M.lsp = function(data)
  local function filter_import_updates(action)
    local kind = action.kind or ""
    local title = action.title or ""
    title = title:lower()

    if kind == "source.organizeImports" then
      return true
    end

    if title:match "import" then
      return true
    end

    if kind:match "quickfix" and title:match "import" then
      return true
    end

    if kind:match "import" then
      return true
    end

    return false
  end

  local import_update_action_opts = {
    filter = filter_import_updates,
    apply = true,
  }

  vim.keymap.set("n", "<leader>th", function()
    local clients = vim.lsp.get_active_clients { bufnr = data.buf }
    local supports_inlay_hints = false

    for _, client in ipairs(clients) do
      if client.supports_method "textDocument/inlayHint" then
        supports_inlay_hints = true
        break
      end
    end

    if not supports_inlay_hints then
      vim.notify("No active LSP client supports inlay hints for this buffer.", vim.log.levels.WARN)
      return
    end

    local current_state = vim.lsp.inlay_hint.is_enabled { bufnr = data.buf }
    vim.lsp.inlay_hint.enable(not current_state, { bufnr = data.buf })
    vim.notify("Inlay hints " .. (not current_state and "enabled" or "disabled"), vim.log.levels.INFO)
  end, { desc = "LSP [T]oggle Inlay [H]ints" })

  map("n", "gd", vim.lsp.buf.definition, { desc = "[G]o to [D]efinition" })
  map("n", "gi", vim.lsp.buf.implementation, { desc = "[G]o to [I]mplementation" })
  map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "[R]e[N]ame" })
  map("n", "gr", vim.lsp.buf.references, { desc = "[R]e[N]ame" })

  map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ction" })
  map("v", "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ction" })

  map("n", "<leader>ci", function()
    vim.lsp.buf.code_action(import_update_action_opts)
  end, { desc = "[C]ode [I]mport" })
  map("v", "<leader>ci", function()
    vim.lsp.buf.code_action(import_update_action_opts)
  end, { desc = "[C]ode [I]mport" })

  vim.keymap.set("n", "<leader>cu", function()
    vim.lsp.buf.code_action {
      context = {
        only = { "source.removeUnused.ts" },
        diagnostics = {},
      },
      apply = true,
    }
  end, { desc = "[C]lean [U]nused (only Typescript)" })
end

M.leap = function()
  map("n", "<leader><leader>", "<Plug>(leap)")
end

M.conform = function()
  map("n", "<leader>fm", function()
    require("conform").format { lsp_fallback = true }
  end, { desc = "[F]or[M]at document" })
end

M.neotree = function()
  map("n", "<leader>n", "<cmd>Neotree show toggle focus float reveal<CR>", { desc = "nvimtree toggle window" })
  map("n", "<leader>e", "<cmd>Neotree show focus float reveal<CR>", { desc = "nvimtree focus window" })
end

M.gitsigns = function(gs, bufnr)
  local function opts(desc)
    return { buffer = bufnr, desc = desc }
  end

  -- Navigation
  map("n", "]c", function()
    if vim.wo.diff then
      vim.cmd.normal { "]c", bang = true }
    else
      gs.nav_hunk("next", { navigation = "all" })
    end
  end)

  map("n", "[c", function()
    if vim.wo.diff then
      vim.cmd.normal { "[c", bang = true }
    else
      gs.nav_hunk("prev", { navigation = "all" })
    end
  end)

  map("n", "<leader>hr", gs.reset_hunk, opts "[H]unk [R]eset")
  map("v", "<leader>hr", function()
    gs.reset_hunk { vim.fn.line ".", vim.fn.line "v" }
  end, opts "[H]unk [R]eset")
  map("n", "<leader>hp", gs.preview_hunk, opts "[H]unk [P]review")
  map("n", "<leader>hd", gs.diffthis, opts "[H]unk [D]iff")
  map("n", "<leader>hD", function()
    gs.diffthis "~"
  end, opts "[H]unk [D]iff ~")
  -- Toggle Operations
  map("n", "<leader>td", gs.toggle_deleted, opts "[T]oggle [D]eleted")
  map("n", "<leader>tb", gs.toggle_current_line_blame, opts "[T]oggle [B]lame")

  -- Blame Operations
  map("n", "<leader>bl", gs.blame_line, opts "[B]lame [L]ine")
end

M.neotest = function()
  map("n", "<leader>tn", "<cmd>lua nequire('neotest').run.run()<CR>", { desc = "[T]est [N]earest" })
  map("n", "<leader>tf", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<CR>", { desc = "[T]est [F]ile" })
  map("n", "<leader>tl", "<cmd>lua require('neotest').run.run_last()<CR>", { desc = "[T]est [L]ast" })
  map("n", "<leader>ts", function()
    local neotest = require "neotest"
    neotest.run.stop()

    if neotest.watch.is_watching() then
      neotest.watch.stop()
    end
  end, { desc = "[T]est [S]top and stop watching" })
  map("n", "<leader>tw", "<cmd>lua require('neotest').watch.watch()<CR>", { desc = "[T]est [W]atch" })
  map("n", "<leader>to", "<cmd>lua require('neotest').output.open()<CR>", { desc = "[T]est [O]utput" })
  map(
    "n",
    "<leader>tO",
    "<cmd>lua require('neotest').output.open({ enter = true })<CR>",
    { desc = "[T]est [O]utput and enter" }
  )
  map("n", "<leader>tt", "<cmd>lua require('neotest').summary.toggle()<CR>", { desc = "[T]est [T]oggle summary" })
end

M.coverage = function()
  map("n", "<leader>cot", function()
    require("coverage").load(true)
  end, { desc = "[C]overage [T]oggle test coverage" })

  map("n", "<leader>cos", function()
    require("coverage").load()
    require("coverage").summary()
  end, { desc = "[C]overage [S]how test coverage summary" })
end

M.telescope = function()
  local telescope_actions = utils.try_require "telescope.actions"

  map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "[F]ind [W]ord (live grep)" })
  map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "[F]ind [B]uffers" })
  map("n", "<leader>fa", "<cmd>Telescope marks<CR>", { desc = "[F]ind [M]arks" })
  map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "[F]ind [O]ldfiles" })
  map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "[F]ind [F]iles" })

  if telescope_actions then
    return {
      n = { ["q"] = require("telescope.actions").close },
    }
  end

  return {}
end

M.trouble = function()
  return {
    {
      "<leader>dt",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "[D]iagnostics [T]oggle (Trouble)",
    },
    {
      "<leader>db",
      "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
      desc = "[D]iagnostics [B]uffer (Trouble)",
    },
    {
      "<leader>ds",
      "<cmd>Trouble symbols toggle focus=false<cr>",
      desc = "[D]iagnostics [S]ymbols (Trouble)",
    },
    {
      "<leader>dl",
      "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
      desc = "[D]iagnostics [L]SP Definitions / references / ... (Trouble)",
    },
    {
      "<leader>dL",
      "<cmd>Trouble loclist toggle<cr>",
      desc = "[D]iagnostics [L]ocation List (Trouble)",
    },
    {
      "<leader>dQ",
      "<cmd>Trouble qflist toggle<cr>",
      desc = "[D]iagnostics [Q]uickfix List (Trouble)",
    },
  }
end

M.blink = {
  preset = "default",
  ["<C-f>"] = { "accept", "fallback" },
}

return M
