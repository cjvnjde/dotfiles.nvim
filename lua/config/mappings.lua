local M = {}
local map = vim.keymap.set

-- Set before loading plugins, including their default mappings.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Plugin-owned keymap options belong here too.
M.blink = {
  preset = "default",
  ["<C-f>"] = { "accept", "fallback" },
}
M.kulala = {
  global_keymaps = false,
  kulala_keymaps_prefix = "",
}

function M.setup()
  -- General editing
  map("n", "<C-h>", "<C-w>h", { desc = "Switch window left" })
  map("n", "<C-l>", "<C-w>l", { desc = "Switch window right" })
  map("n", "<C-j>", "<C-w>j", { desc = "Switch window down" })
  map("n", "<C-k>", "<C-w>k", { desc = "Switch window up" })
  map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })
  map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
  map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })
  map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
  map("x", "<leader>p", '"_dP', { desc = "Paste without yanking" })
  map("x", ">", ">gv", { desc = "Indent selection" })
  map("x", "<", "<gv", { desc = "Unindent selection" })
  map({ "n", "x" }, ";", ":", { silent = false })
  map({ "n", "x" }, ":", ";", { silent = false })
  map("n", "<leader>u", "<cmd>undolist<CR>", { desc = "Undo history" })

  -- Telescope, Leap, and Neo-tree
  map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "Find text" })
  map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Find buffers" })
  map("n", "<leader>fa", "<cmd>Telescope marks<CR>", { desc = "Find marks" })
  map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "Find recent files" })
  map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
  map("n", "<leader>fg", "<cmd>Telescope git_status<CR>", { desc = "Find Git changes" })
  map("n", "<leader><leader>", "<Plug>(leap)", { desc = "Jump with Leap" })
  map("n", "<leader>n", "<cmd>Neotree show toggle focus float reveal<CR>", { desc = "Toggle file tree" })
  map("n", "<leader>e", "<cmd>Neotree show focus float reveal<CR>", { desc = "Focus file tree" })

  -- Formatting and LSP
  map("n", "<leader>fm", function()
    require("conform").format { lsp_format = "fallback" }
  end, { desc = "[F]or[M]at document" })
  map("n", "gl", vim.diagnostic.open_float, { desc = "Show diagnostic message" })
  map("n", "<leader>sd", function()
    local lines = not vim.diagnostic.config().virtual_lines
    vim.diagnostic.config { virtual_lines = lines, virtual_text = not lines }
  end, { desc = "Toggle diagnostic lines/text" })
  map("n", "<leader>sc", function()
    for _, client in ipairs(vim.lsp.get_clients { name = "codebook" }) do
      local ns = vim.lsp.diagnostic.get_namespace(client.id)
      local enabled = not vim.diagnostic.is_enabled { ns_id = ns }
      vim.diagnostic.enable(enabled, { ns_id = ns })
      vim.notify("Codebook diagnostics " .. (enabled and "enabled" or "disabled"))
    end
  end, { desc = "Toggle Codebook diagnostics" })
  map("n", "<leader>th", function()
    local bufnr = vim.api.nvim_get_current_buf()
    if #vim.lsp.get_clients { bufnr = bufnr, method = "textDocument/inlayHint" } == 0 then
      vim.notify("No LSP client supports inlay hints for this buffer", vim.log.levels.WARN)
      return
    end
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = bufnr }, { bufnr = bufnr })
  end, { desc = "Toggle inlay hints" })

  -- Native grn/gra provide rename and code actions without title-based auto-apply.
  map({ "n", "x" }, "<leader>ci", function()
    vim.lsp.buf.code_action {
      context = { only = { "source.organizeImports" }, diagnostics = {} },
      apply = true,
    }
  end, { desc = "Organize imports" })
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("LspMappings", { clear = true }),
    callback = function(event)
      map("n", "gd", vim.lsp.buf.definition, { buffer = event.buf, desc = "Go to definition" })
      local client = vim.lsp.get_client_by_id(event.data.client_id)
      if client and client.name == "ts_ls" then
        map("n", "<leader>cu", function()
          vim.lsp.buf.code_action {
            context = { only = { "source.removeUnused.ts" }, diagnostics = {} },
            apply = true,
          }
        end, { buffer = event.buf, desc = "Remove unused imports and declarations" })
      end
    end,
  })

  -- Testing and coverage; accessors preserve on-demand activation.
  map("n", "<leader>tn", function()
    require("plugins.testing").neotest().run.run()
  end, { desc = "Test nearest" })
  map("n", "<leader>tf", function()
    require("plugins.testing").neotest().run.run(vim.api.nvim_buf_get_name(0))
  end, { desc = "Test file" })
  map("n", "<leader>tl", function()
    require("plugins.testing").neotest().run.run_last()
  end, { desc = "Repeat last test" })
  map("n", "<leader>ts", function()
    local plugin = require("plugins.testing").neotest()
    plugin.run.stop()
    if plugin.watch.is_watching() then
      plugin.watch.stop()
    end
  end, { desc = "Stop tests and watching" })
  map("n", "<leader>tw", function()
    require("plugins.testing").neotest().watch.watch()
  end, { desc = "Watch tests" })
  map("n", "<leader>to", function()
    require("plugins.testing").neotest().output.open()
  end, { desc = "Show test output" })
  map("n", "<leader>tO", function()
    require("plugins.testing").neotest().output.open { enter = true }
  end, { desc = "Enter test output" })
  map("n", "<leader>tt", function()
    require("plugins.testing").neotest().summary.toggle()
  end, { desc = "Toggle test summary" })
  map("n", "<leader>cot", function()
    require("plugins.testing").coverage().load(true)
  end, { desc = "Load and show coverage signs" })
  map("n", "<leader>cos", function()
    require("plugins.testing").coverage().summary()
  end, { desc = "Show loaded coverage summary" })

  -- HTTP
  map({ "n", "x" }, "<leader>Rs", function()
    require("plugins.tools").kulala().run()
  end, { desc = "Send HTTP request" })
  map({ "n", "x" }, "<leader>Ra", function()
    require("plugins.tools").kulala().run_all()
  end, { desc = "Send all HTTP requests" })
  map("n", "<leader>Rb", function()
    require("plugins.tools").kulala().scratchpad()
  end, { desc = "Open HTTP scratchpad" })
end

-- Gitsigns installs these only after attaching to a tracked buffer.
function M.gitsigns(bufnr)
  local gs = require "gitsigns"
  local function opts(desc)
    return { buffer = bufnr, desc = desc }
  end

  map("n", "]c", function()
    if vim.wo.diff then
      vim.cmd.normal { "]c", bang = true }
    else
      gs.nav_hunk("next", { navigation = "all" })
    end
  end, opts "Next Git hunk")
  map("n", "[c", function()
    if vim.wo.diff then
      vim.cmd.normal { "[c", bang = true }
    else
      gs.nav_hunk("prev", { navigation = "all" })
    end
  end, opts "Previous Git hunk")
  map("n", "<leader>hr", gs.reset_hunk, opts "Reset hunk")
  map("x", "<leader>hr", function()
    gs.reset_hunk { vim.fn.line ".", vim.fn.line "v" }
  end, opts "Reset selected hunk")
  map("n", "<leader>hp", gs.preview_hunk, opts "Preview hunk")
  map("n", "<leader>hd", gs.diffthis, opts "Diff against index")
  map("n", "<leader>hD", function()
    gs.diffthis "~"
  end, opts "Diff against previous commit")
  map("n", "<leader>td", gs.preview_hunk_inline, opts "Preview deleted lines inline")
  map("n", "<leader>tb", gs.toggle_current_line_blame, opts "Toggle line blame")
  map("n", "<leader>bl", gs.blame_line, opts "Show line blame")
end

return M
