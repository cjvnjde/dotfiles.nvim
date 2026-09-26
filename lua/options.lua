-- Appearance
vim.o.laststatus = 3
vim.o.showmode = false
vim.o.cursorline = true
vim.o.cursorlineopt = "line"
vim.o.number = true
vim.o.relativenumber = true
vim.o.numberwidth = 2
vim.o.signcolumn = "yes"
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Fallback indentation; Sleuth detects existing style and respects project rules.
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.smartindent = true
vim.o.tabstop = 2
vim.o.softtabstop = -1

vim.o.breakindent = true
vim.o.linebreak = true
vim.o.breakat = " \t!@+;:,./?()[]{}='\"`–—­"
vim.o.showbreak = "↪"
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.inccommand = "split"
vim.o.timeoutlen = 300
vim.o.scrolloff = 10
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.undofile = true
vim.o.updatetime = 250

vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldlevel = 99

vim.diagnostic.config {
  virtual_text = true,
  update_in_insert = true,
  float = { border = "rounded", source = true, wrap = true },
  severity_sort = true,
}
