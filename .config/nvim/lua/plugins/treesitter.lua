-- Parser and syntax highlighter
-- https://github.com/nvim-treesitter/nvim-treesitter

return {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
        { 'nvim-treesitter/nvim-treesitter-context', opts = {} },
    },
    lazy = false,
    build = ':TSUpdate',
    config = function()
        local parsers = {
            'bash',
            'c',
            'c_sharp',
            'css',
            'diff',
            'dockerfile',
            'go',
            'html',
            'javascript',
            'json',
            'lua',
            'luadoc',
            'markdown',
            'markdown_inline',
            'python',
            'query',
            'rust',
            'sql',
            'textproto',
            'toml',
            'typescript',
            'typst',
            'vim',
            'vimdoc',
            'yaml',
            'zig',
        }

        require('nvim-treesitter').install(parsers)

        vim.api.nvim_create_autocmd('FileType', {
            callback = function(args)
                local buf = args.buf
                local fileType = args.match

                local language = vim.treesitter.language.get_lang(fileType)
                if not language then
                    return
                end
                -- check if parser exists and load it
                if not vim.treesitter.language.add(language) then
                    return
                end
                -- enables syntax highlighting and other treesitter features
                vim.treesitter.start(buf, language)

                -- enables treesitter based folds
                -- for more info on folds see `:help folds`
                vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
                vim.wo.foldmethod = 'expr'

                -- enables treesitter based indentation
                vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        })
    end,
}
