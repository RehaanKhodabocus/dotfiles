-- Highlight, list and search todo comments in your projects
-- https://github.com/folke/todo-comments.nvim

return {
    'folke/todo-comments.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    keys = {
        { '<leader>xt', ':TodoFzfLua<CR>', desc = 'Find todos', noremap = true, silent = true },
    },
    opts = {},
}
