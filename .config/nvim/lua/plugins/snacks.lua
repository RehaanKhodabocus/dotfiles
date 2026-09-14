-- A collection of small QoL plugins for Neovim
-- https://github.com/folke/snacks.nvim

return {
    'folke/snacks.nvim',
    priority = 1000,
    opts = {
        animate = { enabled = false },
        bigfile = { enabled = true },
        dashboard = {
            enabled = true,
            sections = {
                { section = 'header' },
                { section = 'keys', gap = 1, padding = 1 },
                { section = 'startup' },
            },
        },
        image = { enabled = true, force = true },
        indent = {
            enabled = true,
            char = '.',
            only_current = true,
        },
        notifier = {
            enabled = true,
            timeout = 3000,
        },
        quickfile = { enabled = true },
        scope = { enabled = false },
    },
    init = function()
        vim.api.nvim_create_autocmd('User', {
            pattern = 'VeryLazy',
            callback = function()
                Snacks.toggle.indent():map('<leader>ti')
                Snacks.toggle.option('wrap', { name = 'Wrap' }):map('<leader>tw')
                Snacks.toggle.inlay_hints():map('<leader>th')
            end,
        })
    end,
}
