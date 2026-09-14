-- Debug Adapter Protocol client implementation for Neovim
-- https://github.com/mfussenegger/nvim-dap

return {
    'mfussenegger/nvim-dap',
    dependencies = {
        -- a UI for nvim-dap
        { 'rcarriga/nvim-dap-ui' },
        -- asynchronous IO librady, required by nvim-dap-ui
        { 'nvim-neotest/nvim-nio', lazy = true },
        -- bridges gaps between mason and nvim-dap
        { 'jay-babu/mason-nvim-dap.nvim', lazy = true },
        -- Adds virtual text support for nvim-dap
        { 'theHamsta/nvim-dap-virtual-text', lazy = true },
        -- debugger extensions
        { 'leoluz/nvim-dap-go', ft = 'go' },
        { 'mfussenegger/nvim-dap-python', ft = 'python' },
    },
    keys = {
        { '<F5>', '<cmd>DapContinue<CR>', desc = 'Debug: Start/Continue' },
        { '<F7>', '<cmd>DapStepInto<CR>', desc = 'Debug: Step into' },
        { '<F8>', '<cmd>DapStepOver<CR>', desc = 'Debug: Step over' },
        { '<S-F8>', '<cmd>DapStepOut<CR>', desc = 'Debug: Step out' },
        { '<F9>', "<cmd>lua require('dapui').toggle()<CR>", desc = 'Debug: See last session result' },
        { '<leader>b', '<cmd>DapToggleBreakpoint<CR>', desc = 'Debug: Toggle breakpoint' },
        { '<leader>B', "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", desc = 'Debug: Set breakpoint' },
        { '<leader>bc', '<cmd>DapClearBreakpoints<CR>', desc = 'Debug: Clear all breakpoints' },
    },
    config = function()
        local dap = require('dap')
        local dapui = require('dapui')

        require('mason-nvim-dap').setup({
            automatic_setup = true,
            handlers = {}, -- can provide additional configuration to handlers
            ensure_installed = { -- update debuggers here based on the language being used
                'delve', -- Go debugger
                'python', -- Python debugger
            },
        })

        require('nvim-dap-virtual-text').setup()

        dapui.setup({
            icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
            controls = {
                icons = {
                    pause = '⏸',
                    play = '▶',
                    step_into = '⏎',
                    step_over = '⏭',
                    step_out = '⏮',
                    step_back = 'b',
                    run_last = '▶▶',
                    terminate = '⏹',
                    disconnect = '⏏',
                },
            },
        })

        vim.fn.sign_define('DapBreakpoint', { text = '🔴', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })

        dap.listeners.after.event_initialized['dapui_config'] = dapui.open
        dap.listeners.before.event_terminated['dapui_config'] = dapui.close
        dap.listeners.before.event_exited['dapui_config'] = dapui.close

        -- .NET debugger setup
        dap.adapters.coreclr = {
            type = 'executable',
            command = vim.fn.expand('~/.local/share/nvim/mason/packages/netcoredbg/libexec/netcoredbg/netcoredbg'),
            args = { '--interpreter=vscode' },
        }

        dap.adapters.netcoredbg = {
            type = 'executable',
            command = vim.fn.expand('~/.local/share/nvim/mason/packages/netcoredbg/libexec/netcoredbg/netcoredbg'),
            args = { '--interpreter=vscode' },
        }

        dap.configurations.cs = {
            {
                type = 'coreclr',
                name = 'Launch - netcoredbg',
                request = 'launch',
                program = function() return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file') end,
            },
        }

        -- Go debugger setup
        require('dap-go').setup({
            delve = {
                path = vim.fn.expand('~/.local/share/nvim/mason/bin/dlv'),
            },
        })

        -- Python debugger setup
        require('dap-python').setup(vim.fn.expand('~/.local/share/nvim/mason/packages/debugpy/venv/bin/python'))

        -- Zig debugger setup
        dap.adapters.lldb = {
            type = 'executable',
            command = '/usr/local/opt/llvm/bin/lldb-dap',
            name = 'lldb',
        }
        dap.configurations.zig = {
            {
                name = 'Launch Zig',
                type = 'lldb',
                request = 'launch',
                program = function() return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/zig-out/bin/', 'file') end,
                cwd = '${workspaceFolder}',
                stopOnEntry = false,
            },
        }
    end,
}
