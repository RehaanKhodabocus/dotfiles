-- Improve Neovim experience
-- https://github.com/nvim-mini/mini.nvim

return {
    -- extend and create a/i textobjects
    {
        'echasnovski/mini.ai',
        event = { 'BufReadPost', 'BufNewFile' },
        config = function()
            local ai = require('mini.ai')

            ai.setup({
                n_lines = 500,
                custom_textobjects = {
                    -- treesitter-based textobjects for functions, classes, parameters
                    f = ai.gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }),
                    c = ai.gen_spec.treesitter({ a = '@class.outer', i = '@class.inner' }),
                    a = ai.gen_spec.treesitter({ a = '@parameter.outer', i = '@parameter.inner' }),
                },
            })
        end,
    },
    -- icon provider (glyph or ascii)
    { 'echasnovski/mini.icons', version = '*', opts = {}, lazy = true },
    -- add character pairs automatically
    { 'echasnovski/mini.pairs', version = '*', event = { 'InsertEnter' }, opts = {} },
    -- add, delete, replace, find, highlight surrounding (brakets, quotes, etc)
    --     add surrounding with sa (in visual mode or on motion).
    --     delete surrounding with sd.
    --     replace surrounding with sr.
    --     find surrounding with sf or sF (move cursor right or left).
    --     highlight surrounding with sh.
    { 'echasnovski/mini.surround', version = '*', event = { 'BufReadPost', 'BufNewFile' }, opts = {} },
}
