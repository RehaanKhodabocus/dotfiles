-- disable <space> in normal and visual modes
vim.keymap.set({ 'n', 'v' }, '<space>', '<Nop>', { silent = true })

-- disable the Q key in normal mode
vim.keymap.set('n', 'Q', '<Nop>', { silent = true })

-- use ctrl+c to exit insert mode (useful for visual-block mode)
vim.keymap.set('i', '<C-c>', '<Esc>', { desc = 'Exit Insert mode', noremap = true, silent = true })

-- use <leader>+q to quit the current window
vim.keymap.set('n', '<leader>q', ':q<CR>', { desc = 'Quit the current window', noremap = true, silent = true })

-- use ctrl+s to write the current to file
vim.keymap.set({ 'n', 'v', 'x' }, '<C-s>', ':w<CR>', { desc = 'Write the current buffer to file', noremap = true, silent = true })

-- better cusror movement
vim.keymap.set({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, desc = 'Move cusror down' })
vim.keymap.set({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, desc = 'Move cusror up' })

-- keep the cursor centered when scrolling
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Move cursor and screen up' })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Move cursor and screen down' })

-- keep the cursor at the same position when searching words under it
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Repeat search in the same direction' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Repeat search in the same direction (backward)' })

-- pane navigation
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move focus to the window below' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move focus to the window above' })
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move focus to the right window' })

-- splitting and resizing
vim.keymap.set('n', '<C-A-Up>', ':resize +2<CR>', { desc = 'Increase window height', noremap = true, silent = true })
vim.keymap.set('n', '<C-A-Down>', ':resize -2<CR>', { desc = 'Decrease window height', noremap = true, silent = true })
vim.keymap.set('n', '<C-A-Left>', ':vertical resize -2<CR>', { desc = 'Decrease window width', noremap = true, silent = true })
vim.keymap.set('n', '<C-A-Right>', ':vertical resize +2<CR>', { desc = 'Increase window width', noremap = true, silent = true })

-- use J/K to move lines up/down
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move line(s) down', noremap = true, silent = true })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move line(s) up', noremap = true, silent = true })

-- better identing
vim.keymap.set('n', '>', '>>', { desc = 'Shift text to the right' })
vim.keymap.set('n', '<', '<<', { desc = 'Shift text to the left' })
vim.keymap.set('v', '>', '>gv', { desc = 'Shift text to the right' })
vim.keymap.set('v', '<', '<gv', { desc = 'Shift text to the left' })

-- clipboard behaviour
-- prevent delete/cut operations from overwriting the clipboard
vim.keymap.set('n', 'd', '"_d', { desc = 'Delete without yanking' })
vim.keymap.set('n', 'x', '"_x', { desc = 'Delete character without yanking' })

-- in visual mode, keep paste from overwriting clipboard
vim.keymap.set('v', 'p', '"_dP', { desc = 'Paste without overwriting clipboard' })
vim.keymap.set('v', 'P', '"_dP', { desc = 'Paste without overwriting clipboard' })
