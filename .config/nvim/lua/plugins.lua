local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])
local packer_bootstrap = nil

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

return require('packer').startup(function(use)
    -- -_-_-_-_- META -_-_-_-_-
    -- IMPATIENT: faster startup time {{{
    use{'lewis6991/impatient.nvim', rocks = 'mpack'}
    -- }}}
    use'wbthomason/packer.nvim'
    -- LSP
    use'neovim/nvim-lspconfig'
    use'williamboman/nvim-lsp-installer'
    use'tami5/lspsaga.nvim'
    use'tamago324/nlsp-settings.nvim' -- 用json配置LSP，像coc.nvim一样
    -- theme
    use'morhetz/gruvbox' -- gruvbox 主题
    use{'AlphaTechnolog/pywal.nvim', as = 'pywal'}
    use'norcalli/nvim-colorizer.lua' -- 颜色
    -- icon
    use'coreyja/fzf.devicon.vim'
    use'ryanoasis/vim-devicons'
    -- writting
    use'junegunn/goyo.vim'
    use'junegunn/limelight.vim'
    use'ferdinandyb/bibtexcite.vim'
    use{'iamcco/markdown-preview.nvim', run = ':call mkdp#util#install()'}
    use'preservim/vim-markdown' -- markdown 方程高亮
    -- 效率
    use'folke/which-key.nvim' -- 助记快捷键
    use'tpope/vim-surround'
    use'sbdchd/neoformat'
    use'h-hg/fcitx.nvim'
    use'ActivityWatch/aw-watcher-vim'
    use'numEricL/vim-gf-list' -- gf 自定义
    use'justinmk/vim-gtfo' -- gf打开文件
    -- term
    use'skywind3000/asyncrun.vim' -- 异步运行
    -- search
    use'ahmedkhalf/project.nvim' -- telescope 查找文件
    use'easymotion/vim-easymotion' -- 单词搜索
    use'wellle/targets.vim' -- 修改一串字符 da< cin) da{
    use'editorconfig/editorconfig-vim' -- .editorconfig 配置
    use{'junegunn/fzf', dir = '~/.fzf', run = ':call fzf#install()'} -- fuzzy 查找
    use'junegunn/fzf.vim'
    use'Avi-D-coder/fzf-wordnet.vim' -- 英文词典
    -- Indent
    use'Yggdroot/indentLine'
    -- Highlight
    use{'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use{
        'nvim-treesitter/playground',
        requires = {{'nvim-treesitter/nvim-treesitter'}}
    }
    use{
        'p00f/nvim-ts-rainbow',
        requires = {{'nvim-treesitter/nvim-treesitter'}}
    }
    use'RRethy/vim-illuminate' -- 单词高亮
    use'folke/lua-dev.nvim' -- lua 语法提示
    use'tridactyl/vim-tridactyl' -- tridactyl 高亮
    -- comment
    use'tpope/vim-commentary' -- 注释代码
    use{
        'JoosepAlviste/nvim-ts-context-commentstring',
        requires = {{'nvim-treesitter/nvim-treesitter'}}
    }
    -- buffer
    use'nvim-lua/plenary.nvim' -- vim的lua接口封装
    use'nvim-lualine/lualine.nvim' -- 底部状态栏
    use{'akinsho/bufferline.nvim', requires = 'kyazdani42/nvim-web-devicons'}
    use{'nvim-telescope/telescope.nvim', requires = {{'nvim-lua/plenary.nvim'}}} -- 搜索 需要搭配ripgrep(live_grep grep_string功能)
    use'nvim-telescope/telescope-file-browser.nvim'
    use{'nvim-telescope/telescope-ui-select.nvim'} -- 选择框 vim.ui.select
    -- Completion
    use{
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'lukas-reineke/cmp-rg',
            'mstanciu552/cmp-matlab', -- matlab 自动补偿
            'hrsh7th/cmp-vsnip',
            'hrsh7th/vim-vsnip',
            'hrsh7th/vim-vsnip-integ'
        }
    }
    use'onsails/lspkind-nvim' -- octave 自动补偿
    use'windwp/nvim-autopairs'
    -- git graph
    use'tpope/vim-fugitive'
    -- File manager
    use{
        'kyazdani42/nvim-tree.lua', -- 文件树 <C-]>进入cursor目录 H 切换.文件隐藏
        requires = {
            'kyazdani42/nvim-web-devicons' -- optional, for file icon
        },
        config = function()
            require'nvim-tree'.setup{}
        end,
        commit = 'd8bf1adcdcc6a8a66c3dce5c29a4ef06e21dc844' -- 指定版本 最新版本可能会有问题
    }
    if packer_bootstrap then require('packer').sync() end

end)
