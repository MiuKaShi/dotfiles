local wk = require('which-key')
wk.register({
    w = {
        name = '+Windows',
        s = {'<C-w>s', 'Split window below'},
        v = {'<C-w>v', 'Split window right'},
        ['-'] = {'<C-w>s', 'Split window below'},
        ['/'] = {'<C-w>v', 'Split window right'},
        w = {'<C-w>w', 'Other window'},
        j = {'<C-w>j', 'Go to the down window'},
        k = {'<C-w>k', 'Go to the up window'},
        h = {'<C-w>h', 'Go to the left window'},
        l = {'<C-w>l', 'Go to the right window'},
        q = {'<C-w>c', 'Close window'},
        m = {'<C-w>o', 'Maximize window'}
    },
    b = {
        name = '+Buffers',
        b = {
            '<cmd>lua require(\'telescope.builtin\').buffers { sort_mru = true }<CR>',
            'List buffers'
        },
        n = {':BufferLineCycleNext<CR>', 'Next buffer'},
        p = {':BufferLineCyclePrev<CR>', 'Previous buffer'},
        d = {':bw<CR>', 'Delete buffer'},
        f = {'<cmd>lua vim.lsp.buf.format()<CR>', 'Format current buffer'},
        c = {'<cmd>BibtexciteInsert<CR>', 'Bib citation insert'},
        v = {'<cmd>BibtexciteShowcite<CR>', 'Bib citation view'}
    },
    f = {
        name = '+Files',
        f = {
            '<cmd>lua require\'functions\'.find_current_directory_files()<CR>',
            'Find file'
        },
        r = {'<cmd>Telescope oldfiles<CR>', 'Open recent file', noremap = false},
        e = {
            name = 'Config files',
            d = {
                '<cmd>lua require\'functions\'.edit_neovim()<CR>',
                'Open dotfiles'
            },
            R = {
                '<cmd>lua require\'functions\'.reload_configuration()<CR>',
                'Reload configuration'
            }
        },
        w = {'<cmd>Telescope grep_string theme=ivy<CR>', 'Find cursor word'},
        s = {'<cmd>w ! sudo tee > /dev/null %<CR>', 'Force save file'},
        t = {
            '<cmd> lua require(\'telescope.builtin\').treesitter()<CR>',
            'trees of functions/variables'
        }
    },
    p = {
        name = '+Projects',
        f = {'<cmd>Telescope find_files<CR>', 'Find file by name(<CTRL-P>)'},
        t = {':Lf<CR>', 'Toggle directory tree'}
    },
    j = {
        name = '+Jump',
        j = {'<Plug>(easymotion-s)', 'Jump to char'},
        l = {'<Plug>(easymotion-bd-jk)', 'Jump to line'},
        i = {
            '<cmd>lua require(\'telescope.builtin\').lsp_document_symbols()<CR>',
            'Jump to symbol'
        }
    },
    s = {
        name = '+Search/Symbols',
        e = {':Lspsaga rename<CR>', 'Edit symbol'},
        s = {
            '<cmd>lua require(\'telescope.builtin\').current_buffer_fuzzy_find { fuzzy = false,  case_mode = \'ignore_case\' }<cr>',
            'Search current buffer'
        },
        h = {
            '<cmd>lua require(\'lspsaga.hover\').render_hover_doc()<CR>',
            'Hover symbol'
        },
        p = {
            '<cmd>lua require\'lspsaga.provider\'.preview_definition()<CR>',
            'Preview symbol'
        },
        H = {
            '<cmd>lua require(\'lspsaga.signaturehelp\').signature_help()<CR>',
            'Show symbol signature'
        }
    },
    g = {
        name = '+Git',
        s = {':Magit<CR>', 'Magit status, see: vimagit'}, -- git状态显示
        g = {':Flog<CR>', 'Show git commit graph'}, -- git图像显示
        c = {
            '<cmd> lua require(\'telescope.builtin\').git_commits()<CR>',
            'Show commits(grep)'
        }, -- git commits 可过滤
        b = {
            '<cmd> lua require(\'telescope.builtin\').git_branches()<CR>',
            'Show branches(grep)'
        } -- git branchs 可过滤
    },
    e = {
        name = '+Errors',
        a = {
            '<cmd>lua require(\'telescope.builtin\').diagnostics{ bufnr=0 }<CR>',
            'List all errors'
        },
        k = {
            '<cmd>lua vim.diagnostic.goto_prev()<CR>',
            'lspsaga.diagnostic PREV'
        },
        j = {
            '<cmd>lua vim.diagnostic.goto_next()<CR>',
            'lspsaga.diagnostic NEXT'
        },
        f = {':Lspsaga code_action<CR>', 'Fix error'}
    },
    [';'] = {
        name = 'Comment',
        [';'] = {'gcc<Esc>', 'Comment line', noremap = false, mode = 'v'}
    },
    ['t'] = {':Lspsaga open_floaterm<CR>', 'Open Terminal(exit with <ESC>)'}, -- 打开终端
    ['*'] = {
        '<cmd>lua require(\'telescope.builtin\').lsp_references()<cr>',
        'Search reference in current project'
    }, -- lsp 查找引用
    ['/'] = {':Telescope live_grep<CR>', 'Fuzzy search in project'}, -- 项目内查找
    ['!'] = {
        ':Telescope help_tags theme=ivy<CR>',
        'Help commands by fuzzy search'
    }, -- vim帮助查找
    ['<Tab>'] = {':b#<CR>', 'Last buffer'},
    ['T'] = {
        '<cmd> lua require(\'telescope.builtin\').builtin()<CR>',
        'Telescope current working directory'
    },
    ['<Space>'] = {':Lf<CR>', 'Toggle directory tree'} -- 查找命令
}, {prefix = '<leader>'})
