--- Lua language server.
--- https://github.com/luals/lua-language-server

return {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = {
        '.git',
        '.luacheckrc',
        '.luarc.json',
        '.luarc.jsonc',
        '.stylua.toml',
        'selene.toml',
        'selene.yml',
        'stylua.toml',
    },
    settings = {
        Lua = {
            completion = {
                callSnippet = 'Replace',
            },
            diagnostics = {
                disable = { 'missing-fields' },
                globals = {
                    'vim',
                    'Snacks',
                },
            },
            hint = {
                enable = true,
                setType = false,
                paramType = true,
                paramName = 'Disable',
                semicolon = 'Disable',
                arrayIndex = 'Disable',
            },
            workspace = {
                library = { [vim.fn.expand('$VIMRUNTIME/lua')] = true },
            },
        },
    },
}
