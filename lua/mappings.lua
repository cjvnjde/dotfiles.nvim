require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map('n', '<C-u>', '<C-u>zz', { desk =  "Move middle up"})
map('n', '<C-d>', '<C-d>zz', { desk =  "Move middle down"})

map('n', '<leader>fm', '<cmd>lua vim.lsp.buf.format({ async = true })<CR>:EslintFixAll<CR>', { desc = "Format document" })

map('v', '>', '>gv', { desc = "Indent text" })
map('v', '<leader>p', '"_dP', { desc = "Paste without yanking" })
map('v', 'y', 'ygv<Esc>', { desc = "Yank and keep selection" })
