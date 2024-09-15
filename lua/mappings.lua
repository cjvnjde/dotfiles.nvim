local M = {}

local map = vim.keymap.set

M.global = function()
  -- [[ NATIVE ]]
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

  map("n", "<C-s>", "<cmd>w<CR>", { desc = "General Save file" })
  map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "General Copy whole file" })

  map("n", "<C-u>", "<C-u>zz", { desc = "Move middle up" })
  map("n", "<C-d>", "<C-d>zz", { desc = "Move middle down" })

  map("v", "<leader>p", '"_dP', { desc = "Paste without yanking" })
  map("v", "y", "ygv<Esc>", { desc = "Yank and keep selection" })
  map("n", "<leader>q", ":cclose<CR>", { desc = "[Q]uit quick fix list", silent = true })

  map("v", ">", ">gv", { desc = "Indent text" })

  map("n", "<leader>fm", function()
    require("conform").format { lsp_fallback = true }
    -- vim.lsp.buf.format { async = true }
  end, { desc = "[F]or[M]at document" })

  -- sway ; and : keys
  map("n", ";", ":", { noremap = true, silent = false })
  map("v", ";", ":", { noremap = true, silent = false })

  map("n", ":", ";", { noremap = true, silent = false })
  map("v", ":", ";", { noremap = true, silent = false })

  -- Comment
  map("n", "<leader>/", "gcc", { desc = "Toggle Comment", remap = true })
  map("v", "<leader>/", "gc", { desc = "Toggle comment", remap = true })

  -- [[ PLUGINS ]]

  -- nvimtree
  map("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })
  map("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", { desc = "nvimtree focus window" })

  -- telescope
  map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "[F]ind [W]ord (live grep)" })
  map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "[F]ind [B]uffers" })
  map("n", "<leader>fa", "<cmd>Telescope marks<CR>", { desc = "[F]ind [M]arks" })
  map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "[F]ind [O]ldfiles" })
  map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "[F]ind [F]iles" })
end

M.cmp = function(cmp)
  return {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),

    ["<CR>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    },

    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { "i", "s" }),
  }
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

M.lsp = function(bufnr)
  local function opts(desc)
    return { buffer = bufnr, desc = "LSP " .. desc }
  end

  map("n", "gd", vim.lsp.buf.definition, opts "[G]o to [D]efinition")
  map("n", "gi", vim.lsp.buf.implementation, opts "[G]o to [I]mplementation")
  map("n", "<leader>rn", vim.lsp.buf.rename, opts "[R]e[N]ame")
  map("n", "<leader>ca", vim.lsp.buf.code_action, opts "[C]ode [A]ction")
  map("v", "<leader>ca", vim.lsp.buf.code_action, opts "[C]ode [A]ction")
end

M.telescope = function()
  return {
    n = { ["q"] = require("telescope.actions").close },
  }
end

return M
