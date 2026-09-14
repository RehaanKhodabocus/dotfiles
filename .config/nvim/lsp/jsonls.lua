--- vscode-json-language-server, a language server for JSON and JSON schema
--- https://github.com/hrsh7th/vscode-langservers-extracted

return {
    cmd = { 'vscode-json-language-server', '--stdio' },
    filetypes = { 'json', 'jsonc' },
    init_options = {
        provideFormatter = true,
    },
    root_markers = { '.git' },
}
