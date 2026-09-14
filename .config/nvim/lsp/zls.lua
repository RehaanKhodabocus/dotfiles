--- Zig LSP implementation + Zig Language Server
--- https://github.com/zigtools/zls

return {
    cmd = { 'zls' },
    filetypes = { 'zig', 'zir' },
    root_markers = { 'zls.json', 'build.zig', '.git' },
    workspace_required = false,
    settings = {
        zls = {
            enablye_inlay_hints = true,
            enable_snippets = true,
            warn_style = true,
        },
    },
}
