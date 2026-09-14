-- Bootstrap lazy.nvim

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
---@diagnostic disable-next-line: undefined-field
if not vim.uv.fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
            { out, 'WarningMsg' },
            { '\nPress any key to exit...' },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

require('core.options')
require('core.keymaps')
require('core.autocmds')
require('core.lsp')

require('lazy').setup({
    spec = {
        { import = 'plugins' },
    },
    change_detection = {
        notify = false,
    },
    checker = {
        enabled = true,
        notify = false,
    },
    install = {
        colorscheme = { 'oxocarbon' },
    },
    performance = {
        rtp = {
            disabled_plugins = {
                '2html_plugin',
                'bugreport',
                'compiler',
                'getscript',
                'getscriptPlugin',
                'gzip',
                'logiPat',
                'man',
                'matchit',
                'matchparen',
                'netrw',
                'netrwFileHandlers',
                'netrwPlugin',
                'optwin',
                'remote_plugins',
                'rplugin',
                'rrhelper',
                'spell',
                'spellfile_plugin',
                'synmenu',
                'syntax',
                'tar',
                'tarPlugin',
                'tohtml',
                'tutor',
                'vimball',
                'vimballPlugin',
                'zip',
                'zipPlugin',
            },
        },
    },
    rocks = { enabled = false },
    ui = {
        icons = vim.g.nerd_fonts and {} or {
            cmd = '⌘',
            config = '🛠',
            event = '📅',
            ft = '📂',
            init = '⚙',
            keys = '🗝',
            plugin = '🔌',
            runtime = '💻',
            source = '📄',
            start = '🚀',
            task = '📌',
        },
    },
})
