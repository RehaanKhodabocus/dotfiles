vim.g.mapleader = ' ' -- change leader to <Space>
vim.g.maplocalleader = ' ' -- change localleader to <Space>
vim.g.nerd_fonts = true -- set to `true` if a Nerd Font is installed

-- Tab / Indentation
vim.opt.breakindent = true -- enable wrapped lines to be indented to line up the start of the line
vim.opt.expandtab = true -- use spaces when <Tab> is inserted
vim.opt.shiftwidth = 2 -- number of spaces to use for (auto)indent step
vim.opt.smartindent = true -- smart autoindenting for C programs
vim.opt.softtabstop = 2 -- number of columns between two soft tab stops
vim.opt.tabstop = 2 -- number of spaces that a <Tab> in the buffer counts for
vim.opt.wrap = false -- disable line wrapping

-- Search
vim.opt.grepformat = '%f:%l:%c:%m' -- format to recognize for the :grep command
vim.opt.grepprg = 'rg --vimgrep --smart-case' -- program to use for the `:grep` command
vim.opt.hlsearch = false -- do not highlight matches on previous search terms
vim.opt.ignorecase = true -- ignore case in search patterns
vim.opt.inccommand = 'split' -- preview substitution live
vim.opt.incsearch = true -- show search matches when typing search command
vim.opt.smartcase = true -- enable case-insensitive search

-- Appearance
vim.opt.background = 'dark' -- `dark` or `light`, used for highlight colors
vim.opt.completeopt = 'menu,menuone,noselect' -- Better completion experience
vim.opt.fillchars = { eob = ' ' } -- remove the `~` character at the end of a buffer
vim.opt.guicursor = 'n-v-c-sm:block-blinkwait175-blinkoff150-blinkon175' -- cursor styling for each mode
vim.opt.number = true -- show absolute line numbers
vim.opt.pumblend = 8 -- enable pseudo-transparency for the popup menu
vim.opt.pumheight = 10 -- maximum number of items to show in the popup menu
vim.opt.relativenumber = true -- show relative line numbers
vim.opt.scrolloff = 8 -- minimum number of lines to show above and below the cursor
vim.opt.showmode = false -- if in inser, replace or visual mode, put a message on the last line
vim.opt.signcolumn = 'yes' -- show sign column so that test doesn't shift
vim.opt.termguicolors = true -- enable 24-bit RGB color
vim.o.winborder = 'rounded' -- default border style for floating windows

-- File handling
vim.opt.autoread = true -- read file when changed outside of Neovim
vim.opt.backup = false -- disable backup file
vim.opt.swapfile = false -- disable swapfile for a buffer
vim.opt.undofile = true -- save undo information in a file
vim.opt.undolevels = 100 -- maximum number of changes that can be undone
vim.opt.writebackup = false -- disable backup when overwriting a file

-- Behaviour
vim.opt.backspace = 'indent,eol,start' -- allow backspace on indent, end of line, and insert mode start position
vim.opt.belloff = 'all' -- turn the bell off for all events
vim.opt.confirm = true -- dialog that asks to confirm saving changes before exiting modified buffer
vim.opt.isfname:append('@-@') -- include `@` in file names and path names
vim.opt.iskeyword:append('-') -- treat words with dahes as a single word
vim.opt.splitbelow = true -- new window from split is below the current one
vim.opt.splitright = true -- new window is put right of the current one
vim.opt.synmaxcol = 300 -- max column to search for syntax items
vim.opt.timeoutlen = 500 -- time in milliseconds to wait for a mapped sequence to complete
vim.opt.updatetime = 100 -- faster completion

-- Folding
vim.opt.foldmethod = 'expr' -- use expression for folding
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()' -- use treesitter for folding
vim.opt.foldlevel = 99

-- use system clipboard as default register
-- schedule the setting after `UiEnter` because it can increase startup-time
vim.schedule(function() vim.opt.clipboard:append('unnamedplus') end)
