-- Dark theme inspired by IBM carbon
-- https://github.com/nyoom-engineering/oxocarbon.nvim

return {
    'nyoom-engineering/oxocarbon.nvim',
    lazy = false,
    priority = 1000,
    config = function()
        -- Clear the background on key highlight groups so Ghostty's
        -- background blur/opacity shows through Neovim. Runs on ColorScheme
        -- so it survives theme reloads and re-applications by other plugins.
        local group = vim.api.nvim_create_augroup('transparent-background', { clear = true })
        vim.api.nvim_create_autocmd('ColorScheme', {
            group = group,
            callback = function()
                for _, name in ipairs({
                    'Normal',
                    'NormalNC',
                    'NormalFloat',
                    'FloatBorder',
                    'SignColumn',
                    'LineNr',
                    'NeoTreeNormal',
                    'NeoTreeNormalNC',
                    'NeoTreeEndOfBuffer',
                }) do
                    vim.api.nvim_set_hl(0, name, { bg = 'none' })
                end
            end,
        })

        vim.cmd('colorscheme oxocarbon')
    end,
}
