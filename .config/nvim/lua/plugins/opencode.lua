-- Neovim frontend for opencode
-- https://github.com/sudo-tee/opencode.nvim

return {
    'sudo-tee/opencode.nvim',
    event = 'VeryLazy',
    config = function()
        require('opencode').setup({
            preferred_picker = 'fzf',
            preferred_completion = 'blink',
        })
    end,
}
