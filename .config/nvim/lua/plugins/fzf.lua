-- A fuzzy finder for Neovim
-- https://github.com/ibhagwan/fzf-lua

return {
    'ibhagwan/fzf-lua',
    cmd = 'FzfLua',
    keys = {
        { '<leader>f/', ':FzfLua lgrep_curbuf<CR>', desc = '[/] Fuzzily search current buffer', noremap = true, silent = true },
        { '<leader>fb', ':FzfLua buffers<CR>', desc = 'Find open buffers', noremap = true, silent = true },
        { '<leader>fd', ':FzfLua diagnostics_workspace<CR>', desc = 'Find diagnostics in workspace', noremap = true, silent = true },
        { '<leader>ff', ':FzfLua files<CR>', desc = 'Find files', noremap = true, silent = true },
        { '<leader>fg', ':FzfLua git_files<CR>', desc = 'Find git files', noremap = true, silent = true },
        { '<leader>fh', ':FzfLua helptags<CR>', desc = 'Search help', noremap = true, silent = true },
        { '<leader>fk', ':FzfLua keymaps<CR>', desc = 'Find keymappings', noremap = true, silent = true },
        { '<leader>fq', ':FzfLua lgrep_quickfix<CR>', desc = 'Search in the quickfix list', noremap = true, silent = true },
        { '<leader>fr', ':FzfLua oldfiles<CR>', desc = 'Find recently opened files', noremap = true, silent = true },
        { '<leader>fs', ':FzfLua live_grep_native<CR>', desc = 'Search current project', noremap = true, silent = true },
        { '<leader>fw', ':FzfLua grep_cword<CR>', desc = 'Search word under cursor', noremap = true, silent = true },
        { '<leader>fW', ':FzfLua grep_cWORD<CR>', desc = 'Search word under cursor', noremap = true, silent = true },
    },
    config = function()
        require('fzf-lua').setup({
            -- { 'ivy' }, -- use Telescope's ivy profile
            { 'fzf-native' }, -- use fzf's native previewing ability
            defaults = {
                prompt = '❯ ',
            },
            buffers = {
                cwd_only = true,
            },
            grep = {
                rg_opts = '--column --line-number --no-heading --color=always --smart-case --hidden --max-columns=4096 -e',
            },
            keymap = {
                builtin = {
                    ['<ESC>'] = 'hide',
                    ['<C-c>'] = 'hide',
                },
            },
            winopts = {
                preview = {
                    default = 'bat_native',
                    title = true,
                },
            },
        })
    end,
}
