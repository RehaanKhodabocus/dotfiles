-- Plugins that require minimal setup are defined here

return {
    -- resuable Lua functions
    { 'nvim-lua/plenary.nvim', lazy = true },
    -- automatic indentation style detection
    { 'nmac427/guess-indent.nvim', event = { 'BufReadPost', 'BufNewFile' } },
    -- improve viewing markdown files in Neovim
    {
        'MeanderingProgrammer/render-markdown.nvim',
        ft = { 'markdown', 'opencode_output' },
        opts = {
            latex = { enabled = false },
            anti_conceal = { enabled = false },
            file_types = { 'markdown', 'opencode_output' },
        },
    },
    -- Neovim notifications and LSP progress messages
    { 'j-hui/fidget.nvim', event = 'LspAttach', opts = { notification = { window = { winblend = 0 } } } },
}
