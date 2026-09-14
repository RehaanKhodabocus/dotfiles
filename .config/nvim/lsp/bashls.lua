--- Language server for bash, written using tree sitter in typescript.
--- https://github.com/bash-lsp/bash-language-server

return {
    cmd = { 'bash-language-server', 'start' },
    settings = {
        bashIde = {
            -- glob pattern for finding and parsing shell script files in the workspace.
            -- used by the background analysis features across files.

            -- prevent recursive scanning which will cause issues when opening a file
            -- directly in the home directory (e.g. ~/foo.sh).
            --
            -- default upstream pattern is "**/*@(.sh|.inc|.bash|.command)".
            globPattern = vim.env.GLOB_PATTERN or '*@(.sh|.inc|.bash|.command)',
        },
    },
    filetypes = { 'bash', 'sh' },
    root_markers = { '.git' },
}
