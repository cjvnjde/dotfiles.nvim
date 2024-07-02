require "nvchad.mappings"

local map = vim.keymap.set

map("n", "<leader>q", ":cclose<CR>", { desc = "[Q]uit quick fix list", silent = true })

map("i", "jk", "<ESC>")

map("n", "<C-u>", "<C-u>zz", { desc = "Move middle up" })
map("n", "<C-d>", "<C-d>zz", { desc = "Move middle down" })

map("n", "<leader>fm", function()
  vim.lsp.buf.format { async = true }
end, { desc = "Format document" })

map("v", ">", ">gv", { desc = "Indent text" })
map("v", "<leader>p", '"_dP', { desc = "Paste without yanking" })
map("v", "y", "ygv<Esc>", { desc = "Yank and keep selection" })

map("n", "<leader>tn", "<cmd>lua require('neotest').run.run()<CR>", { desc = "Run [n]earest test" })
map(
  "n",
  "<leader>tf",
  "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<CR>",
  { desc = "Run tests in current [f]ile" }
)
map("n", "<Leader>tl", ':lua require("neotest").run.run_last()<CR>', { desc = "Run [l]ast test" })
map("n", "<leader>ts", function()
  local neotest = require "neotest"
  neotest.run.stop()

  if neotest.watch.is_watching() then
    neotest.watch.stop()
  end
end, { desc = "[s]top test ant stop watching" })
map("n", "<leader>tw", "<cmd>lua require('neotest').watch.watch()<CR>", { desc = "[w]atch test" })

map("n", "<Leader>to", ':lua require("neotest").output.open()<CR>', { desc = "Show test [o]utput" })
map(
  "n",
  "<Leader>tO",
  ':lua require("neotest").output.open({ enter = true })<CR>',
  { desc = "Show test [O]utput and enter" }
)
map("n", "<Leader>tt", ':lua require("neotest").summary.toggle()<CR>', { desc = "[t]oggle test summary" })

map("n", "<leader>cot", function()
  require("coverage").load(true)
end, { desc = "[t]oggle test coverage" })
map("n", "<leader>cos", function()
  require("coverage").load()
  require("coverage").summary()
end, { desc = "[s]how test coverage summary" })

map("n", ";", ":", { noremap = true, silent = false })
map("v", ";", ":", { noremap = true, silent = false })

map("n", ":", ";", { noremap = true, silent = false })
map("v", ":", ";", { noremap = true, silent = false })
