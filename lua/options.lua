-- Leaders {{{1
-- Set the primary leader keys used across custom mappings.
-- }}}
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Appearance {{{1
-- Configure core editor visuals like colors, statusline, cursor highlighting, and end-of-buffer filler.
-- enables 24-bit colors in the terminal
-- }}}
vim.opt.termguicolors = true
vim.o.laststatus = 3
vim.o.showmode = false
vim.o.cursorline = true
vim.o.cursorlineopt = "line"

-- Indentation {{{1
-- Use two-space indentation, convert tabs to spaces, and keep smart indentation enabled.
-- }}}
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.smartindent = true
vim.o.tabstop = 2
vim.o.softtabstop = 2

-- Wrapping {{{1
-- Soft-wrap long lines at word boundaries and show a continuation marker on wrapped lines.
-- }}}
vim.opt.breakindent = true
vim.opt.linebreak = true
vim.opt.wrap = true
vim.opt.breakat = " ^I!@+;:,./?()[]{}='\"`–—­"
vim.opt.showbreak = "↪"

-- Search {{{1
-- Keep searches case-insensitive unless capitals are used, preview substitutions live, and highlight matches.
-- }}}
vim.o.ignorecase = true
vim.o.smartcase = true
vim.opt.inccommand = "split"
vim.opt.hlsearch = true

-- Input and navigation {{{1
-- Enable mouse support, keep context around the cursor, and keep mapped-sequence timing responsive.
-- Uncomment to allow certain keys to move across line boundaries.
-- opt.whichwrap:append "<>[]hl"
-- }}}
vim.o.mouse = "a"
vim.o.timeoutlen = 300
vim.opt.scrolloff = 10

-- Messages and whitespace {{{1
-- Shows invisible characters
-- }}}
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Numbers and gutters {{{1
-- Show absolute and relative line numbers, keep the number column compact, and always reserve the sign column.
-- }}}
vim.o.number = true
vim.o.relativenumber = true
vim.o.numberwidth = 2
vim.o.ruler = false
vim.o.signcolumn = "yes"

-- Windows and persistence {{{1
-- Open splits in a predictable direction and persist undo history with a responsive update interval.
-- }}}
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.undofile = true
vim.o.updatetime = 250

-- Folding {{{1
-- Use Tree-sitter-based folds globally while keeping normal file folds expanded by default.
-- }}}
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99

-- vim: set fdm=marker fdl=0 fen:
