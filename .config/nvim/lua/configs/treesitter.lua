local treesitter = require('nvim-treesitter.configs')
local ts_install = {
    'bibtex',
    'comment',
    'fish',
    'html',
    'latex',
    'lua',
    'markdown',
    'norg',
    'python',
    'query',
    'ruby',
    'toml',
    'vim',
    'yaml',
    'matlab',
    'norg_meta',
    'norg_table'
}

treesitter.setup{
    ensure_installed = ts_install,
    highlight = {
        enable = true,
        disable = {'markdown'}, -- list of language that will be disabled
        additional_vim_regex_highlighting = false
    },
    incremental_selection = {enable = true},
    indent = {enable = true},
    rainbow = {enable = true, extended_mode = true},
    playground = {enable = true},
    query_linter = {enable = true}
}

local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()

parser_configs.matlab = {
    install_info = {
        url = 'https://github.com/mstanciu552/tree-sitter-matlab',
        files = {'src/parser.c'},
        branch = 'main'
    },
    filetype = 'matlab' -- if filetype does not agrees with parser name
}

parser_configs.norg_meta = {
    install_info = {
        url = 'https://github.com/nvim-neorg/tree-sitter-norg-meta',
        files = {'src/parser.c'},
        branch = 'main'
    }
}

parser_configs.norg_table = {
    install_info = {
        url = 'https://github.com/nvim-neorg/tree-sitter-norg-table',
        files = {'src/parser.c'},
        branch = 'main'
    }
}
