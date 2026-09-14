-- Lightweight yet powerful formatter
-- https://github.com/stevearc/conform.nvim

return {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = 'ConformInfo',
    keys = {
        {
            '<leader>cf',
            function() require('conform').format({ lsp_format = 'fallback', async = true, timeout_ms = 1000 }) end,
            mode = { 'n', 'v' },
            desc = 'Format buffer',
        },
    },
    opts = {
        default_format_opts = { lsp_format = 'fallback' },
        formatters_by_ft = {
            cs = { 'csharpier' },
            go = { 'goimports', 'gofumpt' },
            json = { 'prettier' },
            lua = { 'stylua' },
            markdown = { 'prettier' },
            python = { 'ruff' },
            sh = { 'shfmt' },
            sql = { 'sql-formatter' },
            yaml = { 'prettier' },
            zig = { 'zig fmt' },
        },
        format_on_save = {
            async = false,
            timeout_ms = 1000,
        },
        formatters = {
            shfmt = {
                preprend_args = { '-i', '2' },
            },
            csharpier = function()
                local useDotnet = not vim.fn.executable('csharpier')
                local command = useDotnet and 'dotnet csharpier' or 'csharpier'
                local version_out = vim.fn.system(command .. ' --version')
                local major_version = tonumber((version_out or ''):match('^(%d+)')) or 0
                local is_new = major_version >= 1
                local args = is_new and { 'format', '$FILENAME' } or { '--write-stdout' }
                return {
                    command = command,
                    args = args,
                    stdin = not is_new,
                    require_cwd = false,
                }
            end,
        },
        notify_on_error = false,
    },
}
