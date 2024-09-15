return {
  current_line_blame = true,
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
    delay = 500,
    ignore_whitespace = false,
    virt_text_priority = 100,
    use_focus = true,
  },
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function opts(desc)
      return { buffer = bufnr, desc = desc }
    end

    local map = vim.keymap.set

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
  end,
  signs = {
    add = { text = "+" },
    change = { text = "~" },
    delete = { text = "_" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
  },
}
