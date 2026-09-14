-- Git integration for buffers
-- https://github.com/lewis6991/gitsigns.nvim

return {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
        signs = {
            add = { text = '+' },
            change = { text = '~' },
            delete = { text = '_' },
            topdelete = { text = '‾' },
            changedelete = { text = '~' },
            untracked = { text = '┆' },
        },
    },
    keys = {
        { '<leader>gb', ':Gitsigns blame_line<CR>', desc = 'Git blame line', noremap = true, silent = true },
        { '<leader>gd', ':Gitsigns diffthis<CR>', desc = 'Git diff against index', noremap = true, silent = true },
        { '<leader>gp', ':Gitsigns preview_hunk<CR>', desc = 'Git preview hunk', noremap = true, silent = true },
        { '<leader>gP', ':Gitsigns preview_hunk_inline<CR>', desc = 'Git preview hunk inline', noremap = true, silent = true },
        { '<leader>gr', ':Gitsigns reset_hunk<CR>', desc = 'Git reset hunk', noremap = true, silent = true },
        { '<leader>gR', ':Gitsigns reset_buffer<CR>', desc = 'Git reset buffer', noremap = true, silent = true },
        { '<leader>gs', ':Gitsigns stage_hunk<CR>', desc = 'Git stage hunk', noremap = true, silent = true },
        { '<leader>gS', ':Gitsigns stage_buffer<CR>', desc = 'Git stage buffer', noremap = true, silent = true },
        { '<leader>gu', ':Gitsigns undo_stage_hunk<CR>', desc = 'Git undo stage hunk', noremap = true, silent = true },
    },
}
