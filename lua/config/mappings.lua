local M = {}

local map = vim.keymap.set

-- Global {{{1
M.global = function()
  -- navigate between windows
  map("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
  map("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
  map("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
  map("n", "<C-k>", "<C-w>k", { desc = "switch window up" })

  -- common
  map("n", "<Esc>", "<cmd>noh<CR>", { desc = "General Clear highlights" })
  map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

  map("n", "<C-u>", "<C-u>zz", { desc = "Move middle up" })
  map("n", "<C-d>", "<C-d>zz", { desc = "Move middle down" })

  map("v", "<leader>p", '"_dP', { desc = "Paste without yanking" })

  map("v", ">", ">gv", { desc = "Indent text" })
  map("v", "<", "<gv", { desc = "Indent text" })

  -- swap ; and : keys
  map("n", ";", ":", { noremap = true, silent = false })
  map("v", ";", ":", { noremap = true, silent = false })

  map("n", ":", ";", { noremap = true, silent = false })
  map("v", ":", ";", { noremap = true, silent = false })

  -- Undotree
  map("n", "<leader>u", ":UndotreeToggle<CR>", { desc = "[U]ndo [T]ree" })

  map("n", "<leader>wa", function()
    vim.lsp.buf.code_action {
      apply = true,
      filter = function(action)
        return action.title:lower():match "add"
      end,
    }
  end, { desc = "[W]ord [A]dd" })

  -- Settings toggles
  map("n", "<leader>sd", function()
    local current = vim.diagnostic.config()
    if not current then
      return
    end
    local is_lines_enabled = current.virtual_lines and true or false
    vim.diagnostic.config {
      virtual_lines = not is_lines_enabled,
      virtual_text = is_lines_enabled,
    }
    vim.notify("Diagnostics: " .. (not is_lines_enabled and "Virtual Lines" or "Virtual Text"), vim.log.levels.INFO)
  end, { desc = "[S]et [D]iagnostic view" })

  map("n", "<leader>sc", function()
    local clients = vim.lsp.get_clients { name = "codebook" }

    for _, client in ipairs(clients) do
      local ns = vim.lsp.diagnostic.get_namespace(client.id)
      local is_enabled = vim.diagnostic.is_enabled { ns_id = ns }
      vim.diagnostic.enable(not is_enabled, { ns_id = ns })
      vim.notify("Codebook diagnostics " .. (not is_enabled and "enabled" or "disabled"), vim.log.levels.INFO)
    end
  end, { desc = "[S]et [C]odebook diagnostics" })
end
-- }}}

-- LSP {{{1
M.lsp = function(data)
  local bufnr = data.buf
  local client = vim.lsp.get_client_by_id(data.data.client_id)

  local function filter_import_updates(action)
    local kind = action.kind or ""
    local title = (action.title or ""):lower()

    return kind == "source.organizeImports"
      or title:match "import"
      or (kind:match "quickfix" and title:match "import")
      or kind:match "import"
  end

  local js_ts_filetypes = {
    javascript = true,
    javascriptreact = true,
    typescript = true,
    typescriptreact = true,
  }

  map("n", "<leader>th", function()
    local supports_inlay_hints = false

    for _, attached_client in ipairs(vim.lsp.get_clients { bufnr = bufnr }) do
      if attached_client.supports_method("textDocument/inlayHint", bufnr) then
        supports_inlay_hints = true
        break
      end
    end

    if not supports_inlay_hints then
      vim.notify("No active LSP client supports inlay hints for this buffer.", vim.log.levels.WARN)
      return
    end

    local current_state = vim.lsp.inlay_hint.is_enabled { bufnr = bufnr }
    vim.lsp.inlay_hint.enable(not current_state, { bufnr = bufnr })
    vim.notify("Inlay hints " .. (not current_state and "enabled" or "disabled"), vim.log.levels.INFO)
  end, { buffer = bufnr, desc = "LSP [T]oggle Inlay [H]ints" })

  map("n", "gl", function()
    vim.diagnostic.open_float()
  end, { buffer = bufnr, desc = "Show full diagnostic message" })

  map("n", "[d", function()
    vim.diagnostic.jupm { count = 1, float = true }
  end, { buffer = bufnr, desc = "Go to previous diagnostic" })

  map("n", "]d", function()
    vim.diagnostic.jupm { count = -1, float = true }
  end, { buffer = bufnr, desc = "Go to next diagnostic" })

  map("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "[G]o to [D]efinition" })
  map("n", "gi", vim.lsp.buf.implementation, { buffer = bufnr, desc = "[G]o to [I]mplementation" })
  map("n", "gr", vim.lsp.buf.references, { buffer = bufnr, desc = "[G]o to [R]eference" })

  map("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "[R]e[N]ame" })

  map("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "[C]ode [A]ction" })
  map("v", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "[C]ode [A]ction" })

  local import_update_action_opts = {
    filter = filter_import_updates,
    apply = true,
  }

  map("n", "<leader>ci", function()
    vim.lsp.buf.code_action(import_update_action_opts)
  end, { buffer = bufnr, desc = "[C]ode [I]mport" })

  map("v", "<leader>ci", function()
    vim.lsp.buf.code_action(import_update_action_opts)
  end, { buffer = bufnr, desc = "[C]ode [I]mport" })

  if client and client.name == "ts_ls" and js_ts_filetypes[vim.bo[bufnr].filetype] then
    map("n", "<leader>cu", function()
      vim.lsp.buf.code_action {
        context = {
          only = { "source.removeUnused.ts" },
          diagnostics = {},
        },
        apply = true,
      }
    end, { buffer = bufnr, desc = "[C]lean [U]nused" })
  end
end
-- }}}

-- Leap {{{1
M.leap = function()
  map("n", "<leader><leader>", "<Plug>(leap)")
end
-- }}}

-- Conform {{{1
M.conform = function()
  map("n", "<leader>fm", function()
    require("conform").format { lsp_fallback = true }
  end, { desc = "[F]or[M]at document" })
end
-- }}}

-- Neo-tree {{{1
M.neotree = function()
  map("n", "<leader>n", "<cmd>Neotree show toggle focus float reveal<CR>", { desc = "nvimtree toggle window" })
  map("n", "<leader>e", "<cmd>Neotree show focus float reveal<CR>", { desc = "nvimtree focus window" })
end
-- }}}

-- Gitsigns {{{1
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
-- }}}

-- Neotest {{{1
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
-- }}}

-- Coverage {{{1
M.coverage = function()
  map("n", "<leader>cot", function()
    require("coverage").load(true)
  end, { desc = "[C]overage [T]oggle test coverage" })

  map("n", "<leader>cos", function()
    require("coverage").load()
    require("coverage").summary()
  end, { desc = "[C]overage [S]how test coverage summary" })
end
-- }}}

-- Telescope {{{1
M.telescope = function()
  map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "[F]ind [W]ord (live grep)" })
  map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "[F]ind [B]uffers" })
  map("n", "<leader>fa", "<cmd>Telescope marks<CR>", { desc = "[F]ind [M]arks" })
  map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "[F]ind [O]ldfiles" })
  map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "[F]ind [F]iles" })
  map("n", "<leader>fg", "<cmd>Telescope git_status<CR>", { desc = "[F]ind [G]it files" })
end
-- }}}

-- Blink {{{1
M.blink = {
  preset = "default",
  ["<C-f>"] = { "accept", "fallback" },
}
-- }}}

return M

-- vim: set fdm=marker fdl=0 fen:
