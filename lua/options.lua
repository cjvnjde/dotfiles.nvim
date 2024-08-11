require "nvchad.options"

local opt = vim.opt
local o = vim.o

opt.spelllang = "en_us"
opt.spell = true
-------------------------------------- options ------------------------------------------
-- Set the global statusline (appears at the bottom of all windows)
o.laststatus = 3

-- Hide the mode indicator (e.g., -- INSERT --) as it's often shown in the statusline
o.showmode = false

-- Use system clipboard for all operations instead of vim's internal clipboard
o.clipboard = "unnamedplus"

-- Highlight the entire line the cursor is on
o.cursorline = true

-- Only highlight the line number of the current line, not the entire line
o.cursorlineopt = "line"

-- Indenting
-- Convert tabs to spaces
o.expandtab = true
-- Set the number of spaces used for each step of (auto)indent
o.shiftwidth = 2
-- Automatically insert indents in appropriate circumstances (e.g., for new code blocks)
o.smartindent = true
-- Set the number of spaces that a <Tab> counts for
o.tabstop = 2
-- Set the number of spaces that a <Tab> counts for while performing editing operations
o.softtabstop = 2

-- Enable smart line breaking and indentation for wrapped lines
opt.breakindent = true
-- Break lines at word boundaries
opt.linebreak = true
-- Enable soft wrapping of long lines
opt.wrap = true

-- Set the characters that WORD boundaries are allowed to occur at
opt.breakat = " ^I!@+;:,./?()[]{}='\"`–—­"

-- Set the string to put at the start of lines that have been wrapped
opt.showbreak = "↪"

-- Set the character to use for filling the space at the end of buffer lines
-- This replaces the default '~' with '░'
opt.fillchars = { eob = "░" }

-- Make searches case-insensitive...
o.ignorecase = true
-- ...unless they contain at least one capital letter
o.smartcase = true

-- Enable mouse support in all modes (normal, visual, insert, command)
o.mouse = "a"

-- Numbers
-- Show line numbers
o.number = true
-- Set the minimum number of columns to use for the line number
o.numberwidth = 2
-- Hide the ruler (line and column number of the cursor position) from the status line
o.ruler = false

-- Disable the Neovim intro message when starting without a file
opt.shortmess:append "sI"

-- Sets how neovim will display certain whitespace characters in the editor.
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Always show the sign column to prevent the text from shifting
o.signcolumn = "yes"

-- Open new split panes to the right and bottom, which feels more natural
o.splitbelow = true
o.splitright = true

-- Set the time in milliseconds to wait for a mapped sequence to complete
o.timeoutlen = 300

-- Enable persistent undo, allowing you to undo changes even after closing and reopening a file
o.undofile = true

-- Set the interval (in milliseconds) for writing the swap file to disk
-- This also affects the update time for git signs and other plugins
o.updatetime = 250

-- Allow certain keys to move to the previous/next line when at the start/end of a line
-- This includes arrow keys (<>), square brackets ([]), h, and l
opt.whichwrap:append "<>[]hl"

-- Preview substitutions live, as you type!
opt.inccommand = "split"

-- Minimal number of screen lines to keep above and below the cursor.
opt.scrolloff = 10

-- Set highlight on search
opt.hlsearch = true
