-- Native LSP and diagnostics setup

-- enable LSP servers
vim.lsp.enable({
    'bashls',
    'gopls',
    'jsonls',
    'lua_ls',
    'ruff',
    'sqlls',
    'yaml_ls',
    'zls',
})

vim.lsp.config('roslyn', {
    settings = {
        ['csharp|inlay_hints'] = {
            csharp_enable_inlay_hints_for_implicit_object_creation = true,
            csharp_enable_inlay_hints_for_implicit_variable_types = true,
        },
        ['csharp|code_lens'] = {
            dotnet_enable_references_code_lens = true,
            dotnet_enable_tests_code_lens = true,
        },
        ['csharp|symbol_search'] = {
            dotnet_search_reference_assemblies = true,
        },
    },
})

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
    callback = function(event)
        local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        map('K', vim.lsp.buf.hover, 'Hover documentation')
        map('gD', vim.lsp.buf.declaration, 'Goto declaration')
        map('gO', vim.lsp.buf.document_symbol, 'Document symbols')
        map('gd', vim.lsp.buf.definition, 'Goto definition')
        map('gra', vim.lsp.buf.code_action, 'Code actions', { 'n', 'x' })
        map('gri', vim.lsp.buf.implementation, 'Goto implementation')
        map('grn', vim.lsp.buf.rename, 'Rename')
        map('grr', vim.lsp.buf.references, 'Goto references')
        map('grt', vim.lsp.buf.type_definition, 'Goto type definitions')
        map('gs', vim.lsp.buf.signature_help, 'Signature help')

        -- highlight references of the word under the cursor
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.document_highlight,
            })

            -- clear highlight of references
            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                group = highlight_augroup,
                buffer = event.buf,
                callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
                group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
                callback = function(event2)
                    vim.lsp.buf.clear_references()
                    vim.api.nvim_clear_autocmds({ group = 'lsp-highlight', buffer = event2.buf })
                end,
            })
        end

        -- log only errors
        vim.lsp.log.set_level('error')

        -- change diagnostic symbols in the sign column (gutter)
        if vim.g.nerd_fonts then
            local signs = { ERROR = ' ', WARN = ' ', INFO = ' ', HINT = '' }
            local diagnostic_signs = {}
            for type, icon in pairs(signs) do
                diagnostic_signs[vim.diagnostic.severity[type]] = icon
            end
            vim.diagnostic.config({
                severity_sort = true,
                underline = true,
                virtual_text = { current_line = true },
                jump = { float = true },
                signs = { text = diagnostic_signs },
                float = { border = 'rounded', source = 'if_many' },
            })
        end
    end,

    -- Diagnostics keymap
    vim.keymap.set('n', '<leader>d', ':FzfLua lsp_document_diagnostics<CR>', { desc = 'Show buffer diagnostics', noremap = true, silent = true }),
    vim.keymap.set('n', '<leader>D', ':FzfLua lsp_workspace_diagnostics<CR>', { desc = 'Show workspace diagnostics', noremap = true, silent = true }),
})

-- get information on attached LSP clients
vim.api.nvim_create_user_command('LspInfo', ':checkhealth vim.lsp', { desc = 'Alias to `:checkhealth vim.lsp`' })

-- restart LSP clients for the current buffer
vim.api.nvim_create_user_command('LspRestart', function()
    local bufnr = vim.api.nvim_get_current_buf()
    local clients = vim.lsp.get_clients({ bufnr = bufnr })
    for _, client in ipairs(clients) do
        vim.lsp.client.stop(client, nil)
    end
    vim.defer_fn(function() vim.cmd('edit') end, 100)
end, { desc = 'Restart LSP clients for the current buffer' })
