local map = vim.keymap.set

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
  vim.lsp.buf.format { async = true }
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

-- git blame
map("n", "<leader>bt", "<cmd>GitBlameToggle<CR>", { desc = "Git [B]lame [T]oggle" })
