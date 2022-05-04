local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])
local packer_bootstrap = nil

-- Automatically install packer
if not packer_exists then
    if vim.fn.input('Download Packer? (y for yes) ') ~= 'y' then
        print('Please install Packer first!')
        return
    end

    local directory = string.format('%s/site/pack/packer/opt/',
                       vim.fn.stdpath('data'))

    vim.fn.mkdir(directory, 'p')

    print(' Downloading packer.nvim...')
    local install_path = directory .. '/packer.nvim'
    packer_bootstrap = vim.fn.system({
        'git',
        'clone',
        '--depth',
        '1',
        'https://github.com/wbthomason/packer.nvim',
        install_path
    })
    print(packer_bootstrap)

    vim.cmd[[packadd packer.nvim]]
end

-- plugin lists
return require('packer').startup(function(use)
    -- -_-_-_-_- META -_-_-_-_-
    -- IMPATIENT: faster startup time {{{
    use{'lewis6991/impatient.nvim', rocks = 'mpack'}
    -- }}}
    use'wbthomason/packer.nvim'
    -- theme
    use'morhetz/gruvbox' -- gruvbox 主题
    use{
        'norcalli/nvim-colorizer.lua', -- editor 内颜色显示
        config = [[require('configs.colorizer')]]
    }
    -- LSP
    use'neovim/nvim-lspconfig' -- lsp 配置插件
    use'onsails/lspkind-nvim' -- vscode-like lsp 提示
    use{'tami5/lspsaga.nvim', config = [[require('configs.lspsaga')]]} -- LSP UI
    use{'sbdchd/neoformat', config = [[require('configs.neoformat')]]}
    -- Highlight
    use{
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        before = 'neorg',
        config = [[require('configs.treesitter')]]
    }
    use{'nvim-treesitter/playground'}
    use{'lambdalisue/vim-cython-syntax'}
    use{
        'vim-pandoc/vim-pandoc-syntax',
        config = function()
            vim.cmd[[
        augroup pandoc_syntax
        autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown
        autocmd BufNewFile,BufFilePre,BufRead *.md set syntax=markdown.pandoc
        augroup END
      ]]
        end
    }
    use{'luochen1990/rainbow', config = [[require('configs.rainbow')]]} -- 嵌套括号高亮
    use{'RRethy/vim-illuminate', config = [[require('configs.illuminate')]]} -- 高亮选中单词
    use'folke/lua-dev.nvim' -- lua 语法提示 for lsp
    use'tridactyl/vim-tridactyl' -- tridactyl 高亮
    -- Completion
    use{
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lua',
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'lukas-reineke/cmp-rg',
            -- 'mstanciu552/cmp-octave', -- octave 自动补偿
            'mstanciu552/cmp-matlab' -- matlab 自动补偿
        },
        config = [[require('configs.cmp')]]
    }
    use{'L3MON4D3/LuaSnip', config = [[require('configs.luasnip')]]}
    use{'windwp/nvim-autopairs', config = [[require('configs.pairs')]]}
    use{
        'tzachar/cmp-tabnine',
        run = './install.sh',
        requires = 'hrsh7th/nvim-cmp',
        config = [[require('configs.tabnine')]]
    } -- AI Completion
    use{
        'github/copilot.vim',
        opt = true,
        config = [[require('configs.copilot')]]
    }

    -- comment
    use{
        'numToStr/Comment.nvim',
        config = [[require('Comment').setup({ padding = function () return vim.bo.filetype ~= 'norg' end })]]
    }
    -- line buffer
    use{
        'nvim-lualine/lualine.nvim', -- 底部状态栏
        config = [[require('configs.lualine')]]
    }
    -- Indent
    use{
        'lukas-reineke/indent-blankline.nvim',
        config = [[require('configs.indentline')]]
    }
    -- Julia
    use{'JuliaEditorSupport/julia-vim', config = [[require('configs.julia')]]}
    -- writting
    use{
        'junegunn/limelight.vim',
        requires = {'junegunn/goyo.vim'},
        config = [[require('configs.limelight')]]
    } -- another zen mode
    use{
        'ferdinandyb/bibtexcite.vim', -- bib 引用
        config = [[require('configs.bibtexcite')]]
    }
    use{'iamcco/markdown-preview.nvim', run = ':call mkdp#util#install()'} -- markdown preview
    -- Task Warrior / Vim Wiki
    use{
        'nvim-neorg/neorg', -- org 模式
        tag = '0.0.11',
        requires = {'nvim-lua/plenary.nvim', 'nvim-neorg/neorg-telescope'},
        config = [[require('configs.neorg')]]
    }
    use'tpope/vim-surround' -- 修改包围符合
    use'wellle/targets.vim' -- 修改包围内内容
    -- search
    -- use 'easymotion/vim-easymotion' -- 单词搜索
    use{'ggandor/leap.nvim', config = [[require('leap').set_default_keymaps()]]}
    use{'junegunn/fzf', dir = '~/.fzf', run = ':call fzf#install()'} -- fuzzy 查找
    use'junegunn/fzf.vim' -- needed for previews
    use'Avi-D-coder/fzf-wordnet.vim' -- 英文词典
    use{
        'nvim-telescope/telescope.nvim', -- 搜索
        requires = {
            'nvim-lua/plenary.nvim' -- Useful lua function used by lots of plugins
        },
        config = [[require('configs.telescope')]]
    }
    use'nvim-telescope/telescope-file-browser.nvim'
    use{'nvim-telescope/telescope-ui-select.nvim'} -- 选择框 vim.ui.select
    -- File manager
    use{'is0n/fm-nvim', config = [[require('configs.fm')]]}
    -- Others
    use{
        'folke/which-key.nvim', -- 快捷键 maps
        config = [[require('configs.whichkey')]]
    }
    use'h-hg/fcitx.nvim' -- fcitx5 自动切换
    use'wakatime/vim-wakatime'
    use'numEricL/vim-gf-list' -- gf 自定义
    use'justinmk/vim-gtfo' -- gf打开文件
    use'skywind3000/asyncrun.vim' -- 异步运行
    if packer_bootstrap then require('packer').sync() end

end)
