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
    'julia',
    'norg'
}

treesitter.setup{
    ensure_installed = ts_install,
    highlight = {enable = true, additional_vim_regex_highlighting = {'latex'}},
    incremental_selection = {enable = true},
    indent = {enable = true},
    playground = {enable = true},
    query_linter = {enable = true}
}
