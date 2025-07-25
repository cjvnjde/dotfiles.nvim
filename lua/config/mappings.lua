local M = {}

local map = vim.keymap.set

local function is_quickfix_open()
  for _, win in ipairs(vim.fn.getwininfo()) do
    if win.quickfix == 1 then
      return true
    end
  end

  return false
end

local function try_require(module_name)
  local ok, module = pcall(require, module_name)

  if ok then
    return module
  else
    print(string.format("Module '%s' not found.", module_name))
    return nil
  end
end

M.global = function()
  -- move cursor in input mode
  map("i", "<C-b>", "<ESC>^i", { desc = "Move [B]eginning of line" })
  map("i", "<C-e>", "<End>", { desc = "Move [E]nd of line" })
  map("i", "<C-h>", "<Left>", { desc = "move left" })
  map("i", "<C-l>", "<Right>", { desc = "move right" })
  map("i", "<C-j>", "<Down>", { desc = "move down" })
  map("i", "<C-k>", "<Up>", { desc = "move up" })

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
  map("v", "y", "ygv<Esc>", { desc = "Yank and keep selection" })

  map("v", ">", ">gv", { desc = "Indent text" })

  -- swap ; and : keys
  map("n", ";", ":", { noremap = true, silent = false })
  map("v", ";", ":", { noremap = true, silent = false })

  map("n", ":", ";", { noremap = true, silent = false })
  map("v", ":", ";", { noremap = true, silent = false })

  -- Comment
  map("n", "<leader>/", "gcc", { desc = "Toggle Comment", remap = true })
  map("v", "<leader>/", "gc", { desc = "Toggle comment", remap = true })

  -- Quickfix
  map("n", "<leader>q", ":cclose<CR>", { desc = "[Q]uit quick fix list", silent = true })
  map("n", "<leader>tq", function()
    if is_quickfix_open() then
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

M.harpoon = function()
  local harpoon = try_require "harpoon"

  if harpoon then
    map("n", "<M-a>", function()
      harpoon:list():add()
    end)

    map("n", "<M-d>", function()
      harpoon:list():remove()
    end)

    local conf = require("telescope.config").values

    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require("telescope.pickers")
        .new({}, {
          prompt_title = "Harpoon",
          finder = require("telescope.finders").new_table {
            results = file_paths,
          },
          previewer = conf.file_previewer {},
          sorter = conf.generic_sorter {},
        })
        :find()
    end

    map("n", "<leader>fh", function()
      toggle_telescope(harpoon:list())
    end, { desc = "[F]ind [H]arpoon" })

    map("n", "<M-e>", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end)
    map("n", "<M-h>", function()
      harpoon:list():select(1)
    end, { desc = "Go to Harpoon 1" })
    map("n", "<M-t>", function()
      harpoon:list():select(2)
    end, { desc = "Go to Harpoon 2" })
    map("n", "<M-n>", function()
      harpoon:list():select(3)
    end, { desc = "Go to Harpoon 3" })
    map("n", "<M-s>", function()
      harpoon:list():select(4)
    end, { desc = "Go to Harpoon 4" })
    map("n", "<M-b>", function()
      harpoon:list():prev()
    end)
    map("n", "<M-l>", function()
      harpoon:list():next()
    end)
  end
end

M.leap = function()
  map("n", "<leader><leader>", "<Plug>(leap)")
end

M.conform = function()
  map("n", "<leader>fm", function()
    require("conform").format { lsp_fallback = true }
  end, { desc = "[F]or[M]at document" })
end

M.nvimtree = function()
  map("n", "<leader>n", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })
  map("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", { desc = "nvimtree focus window" })
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
      gs.nav_hunk "next"
    end
  end)

  map("n", "[c", function()
    if vim.wo.diff then
      vim.cmd.normal { "[c", bang = true }
    else
      gs.nav_hunk "prev"
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
  local telescope_actions = try_require "telescope.actions"

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
