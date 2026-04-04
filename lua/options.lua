local opt = vim.opt
local o = vim.o
local g = vim.g

-- Leaders {{{1
-- Set the primary leader keys used across custom mappings.
-- }}}
g.mapleader = " "
g.maplocalleader = "\\"

-- Appearance {{{1
-- Configure core editor visuals like colors, statusline, cursor highlighting, and end-of-buffer filler.
-- }}}
opt.termguicolors = true
o.laststatus = 3
o.showmode = false
o.cursorline = true
o.cursorlineopt = "line"
opt.fillchars = { eob = "░" }

-- Indentation {{{1
-- Use two-space indentation, convert tabs to spaces, and keep smart indentation enabled.
-- }}}
o.expandtab = true
o.shiftwidth = 2
o.smartindent = true
o.tabstop = 2
o.softtabstop = 2

-- Wrapping {{{1
-- Soft-wrap long lines at word boundaries and show a continuation marker on wrapped lines.
-- }}}
opt.breakindent = true
opt.linebreak = true
opt.wrap = true
opt.breakat = " ^I!@+;:,./?()[]{}='\"`–—­"
opt.showbreak = "↪"

-- Search {{{1
-- Keep searches case-insensitive unless capitals are used, preview substitutions live, and highlight matches.
-- }}}
o.ignorecase = true
o.smartcase = true
opt.inccommand = "split"
opt.hlsearch = true

-- Input and navigation {{{1
-- Enable mouse support, keep context around the cursor, and keep mapped-sequence timing responsive.
-- Uncomment to allow certain keys to move across line boundaries.
-- opt.whichwrap:append "<>[]hl"
-- }}}
o.mouse = "a"
o.timeoutlen = 300
opt.scrolloff = 10

-- Messages and whitespace {{{1
-- Hide the startup intro, show invisible characters, and leave system clipboard sync ready to enable.
-- Uncomment to use the system clipboard for all operations.
-- o.clipboard = "unnamedplus"
-- }}}
opt.shortmess:append "sI"
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Numbers and gutters {{{1
-- Show absolute and relative line numbers, keep the number column compact, and always reserve the sign column.
-- }}}
o.number = true
o.relativenumber = true
o.numberwidth = 2
o.ruler = false
o.signcolumn = "yes"

-- Windows and persistence {{{1
-- Open splits in a predictable direction and persist undo history with a responsive update interval.
-- }}}
o.splitbelow = true
o.splitright = true
o.undofile = true
o.updatetime = 250

-- Folding {{{1
-- Use Tree-sitter-based folds globally while keeping normal file folds expanded by default.
-- }}}
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldlevel = 99

-- vim: set fdm=marker fdl=0 fen:
