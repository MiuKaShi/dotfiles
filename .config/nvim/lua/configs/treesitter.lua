local ts_install = {
    "bash",
    "python",
    "c",
    "cpp",
    "cmake",
    "css",
    'comment',
    "dockerfile",
    "go",
    "gomod",
    "java",
    "javascript",
    "typescript",
    "json",
    "vue",
    'bibtex',
    'html',
    'latex',
    'lua',
    'query',
    'ruby',
    'toml',
    'vim',
    'yaml',
    'julia',
    'norg',
}

require('nvim-treesitter.configs').setup {
    ensure_installed = ts_install,
    highlight = { enable = true, additional_vim_regex_highlighting = { 'latex' } },
    incremental_selection = { enable = true },
    indent = { enable = true },
    playground = { enable = true },
    query_linter = { enable = true },
}

-- Add Markdown
local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
parser_config.diff = {
    install_info = {
        url = "https://github.com/vigoux/tree-sitter-diff",
        files = { "src/parser.c" }
    },
    filetype = "diff"
}
parser_config.puml = {
    install_info = {
        url = "https://github.com/ahlinc/tree-sitter-plantuml",
        revision = "demo",
        files = { "src/scanner.cc" },
    },
    filetype = "puml",
}
parser_config.md = {
    install_info = {
        url = "https://github.com/ikatyang/tree-sitter-markdown",
        revision = "master",
        files = { "src/parser.c", "src/scanner.cc" },
    },
    filetype = "markdown",
}
