-- Browse the file system and other tree like structures
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
    'nvim-neo-tree/neo-tree.nvim',
    version = '*',
    dependencies = {
        'MunifTanjim/nui.nvim',
    },
    keys = {
        { '\\', '<cmd>Neotree toggle<CR>', desc = 'Toogle file explorer', silent = true },
    },
    lazy = false,
    config = function()
        -- get icons from mini.icons
        require('mini.icons').setup()
        ---@diagnostic disable-next-line: undefined-global
        MiniIcons.mock_nvim_web_devicons()

        -- define diagnostic icons
        vim.fn.sign_define('DiagnosticSignError', { text = ' ', texthl = 'DiagnosticSignError' })
        vim.fn.sign_define('DiagnosticSignWarn', { text = ' ', texthl = 'DiagnosticSignWarn' })
        vim.fn.sign_define('DiagnosticSignInfo', { text = ' ', texthl = 'DiagnosticSignInfo' })
        vim.fn.sign_define('DiagnosticSignHint', { text = '󰌵', texthl = 'DiagnosticSignHint' })

        require('neo-tree').setup({
            close_if_last_window = false,
            filesystem = {
                filtered_items = {
                    hide_dotfiles = false,
                    hide_by_name = {
                        'node_modules',
                        '.virtual_documents',
                        '.python-version',
                        '.venv',
                    },
                    never_show = {
                        '.DS_Store',
                        '.git',
                    },
                },
                follow_current_file = {
                    enabled = true,
                },
                use_libuv_file_watcher = true,
            },
            window = {
                position = 'left',
                width = 40,
                mappings = {
                    ['<space>'] = 'noop',
                },
            },
        })
    end,
}
