local utils = require('utils')

local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()
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
-- Setup for tree-sitter
utils.safe_require('nvim-treesitter.configs', function(treesitter)
    treesitter.setup{
        -- One of "all", "maintained" (parsers with maintainers), or a list of languages
        ensure_installed = 'maintained',

        -- Install languages synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- List of parsers to ignore installing
        ignore_install = {},

        highlight = {
            -- `false` will disable the whole extension
            enable = true,
            disable = {'markdown'}, -- list of language that will be disabled
            additional_vim_regex_highlighting = false
        },

        playground = {
            enable = true,
            disable = {},
            updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
            persist_queries = false, -- Whether the query persists across vim sessions
            keybindings = {
                toggle_query_editor = 'o',
                toggle_hl_groups = 'i',
                toggle_injected_languages = 't',
                toggle_anonymous_nodes = 'a',
                toggle_language_display = 'I',
                focus_language = 'f',
                unfocus_language = 'F',
                update = 'R',
                goto_node = '<cr>',
                show_help = '?'
            }
        },

        rainbow = {
            enable = true,
            -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
            extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
            max_file_lines = nil -- Do not enable for files with more than n lines, int
            -- colors = {}, -- table of hex strings
            -- termcolors = {} -- table of colour name strings
        },

        context_commentstring = {enable = true}
    }
end)
-- End of setup for tree-sitter

