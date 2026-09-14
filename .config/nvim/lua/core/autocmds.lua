local autocmd = vim.api.nvim_create_autocmd
local group = vim.api.nvim_create_augroup('custom', { clear = true })

-- check if we need to reload the buffer when it changed
autocmd({ 'CursorHold', 'FocusGained', 'TermClose', 'TermLeave' }, {
    group = group,
    command = 'checktime',
})

-- disable automatic comment continuation
autocmd('BufEnter', {
    group = group,
    callback = function() vim.opt.formatoptions = vim.opt.formatoptions - { 'c', 'r', 'o' } end,
})

-- highlight text on yank
autocmd('TextYankPost', {
    group = group,
    callback = function() vim.hl.on_yank({ hlgroup = 'IncSearch', timeout = 100 }) end,
})

-- wrap and check for spelling in text filetypes
autocmd('FileType', {
    group = group,
    pattern = { 'gitcommit', 'markdown', 'text' },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
})

-- close some file types with <q>
autocmd('FileType', {
    group = group,
    pattern = {
        'checkhealth',
        'help',
        'lspinfo',
        'notify',
        'qf',
    },
    callback = function(evt)
        vim.bo[evt.buf].buflisted = false
        vim.keymap.set('n', 'q', '<cmd>close<CR>', { buffer = evt.buf, silent = true })
    end,
})

-- go to the last known location when opening a buffer
autocmd('BufReadPost', {
    group = group,
    callback = function(event)
        local exclude = { 'gitcommit' }
        local buf = event.buf
        if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].last_loc then
            return
        end
        vim.b[buf].last_loc = true
        local mark = vim.api.nvim_buf_get_mark(buf, '"')
        local lcount = vim.api.nvim_buf_line_count(buf)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- toggle cursorline.
autocmd({ 'BufEnter', 'FocusGained', 'InsertLeave', 'WinEnter' }, {
    group = group,
    callback = function() vim.opt_local.cursorline = true end,
})

autocmd({ 'FocusLost', 'InsertEnter', 'WinLeave' }, {
    group = group,
    callback = function() vim.opt_local.cursorline = false end,
})

-- toggle relativenumber based on mode
autocmd('InsertLeave', {
    group = group,
    callback = function() vim.opt_local.relativenumber = true end,
})

autocmd('InsertEnter', {
    group = group,
    callback = function() vim.opt_local.relativenumber = false end,
})
