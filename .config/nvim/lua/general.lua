local g = vim.g
local opt = vim.opt

g.mapleader = ' '
g.user_emmet_settings = {
    javascript = {extends = 'jsx'},
    typescript = {extends = 'tsx'}
}
g.rainbow_active = 1
g.neon_style = 'doom'
g.EasyMotion_do_mapping = 0
g.EasyMotion_smartcase = 1
g.swoopAutoInsertMode = 1
-- g.rust_clip_command = 'pbcopy'
-- g.python3_host_prog = '~/.pyenv/versions/nvim-py3/bin/python'
g.indentLine_fileTypeExclude = {'alpha'}
g.user_emmet_install_global = 0
-- g.copilot_no_tab_map = true
-- g.copilot_assume_mapped = true
-- snippets
g.vsnip_snippet_dir = '~/.config/nvim/snippets/'
-- vimwiki
g.vimwiki_list = { { path = '~/vimwiki/', syntax = 'markdown', ext = '.md' } }
g.taskwiki_dont_fold = 'yes'
 -- gf 自定义
g.GfList_map_n_gf = 'gf'
g.GfList_map_v_gf = 'gf'
vim.cmd[[
let g:gtfo#terminals = { 'unix': 'st -e nvim' }
]]
-- netrw
-- g.netrw_banner = 1
-- g.netrw_winsize = '80%'
-- g.netrw_browse_split = 4
-- g.netrw_altv = 1
-- g.netrw_liststyle = 3

opt.complete = ''
opt.background = 'dark'
-- vim.cmd('silent! colorscheme neon')
vim.cmd('syntax on') -- 打开语法高亮
vim.cmd('filetype plugin indent on') -- 根据检测到文件类型加载插件

local indent = 4

opt.cursorline = true -- 快速找到当前行
vim.cmd[[
autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline
]]
opt.timeoutlen = 500
opt.mouse = 'a'
opt.encoding = 'UTF-8'
opt.fileencoding = 'UTF-8'
opt.fileencodings = 'UTF-8'
opt.termguicolors = true
opt.number = true
opt.lazyredraw = true -- Speeds up scrolling
opt.redrawtime = 10000
opt.regexpengine = 1
-- opt.showbreak = '+++'
opt.relativenumber = true
opt.scrolloff = 2 -- Always show at least one line above/below the cursor.
opt.sidescrolloff = 5 -- Always show at least one line left/right of the cursor.
opt.linebreak = true
opt.showmatch = true
opt.visualbell = true

opt.hlsearch = true -- 保持匹配项目高亮
opt.smartcase = true
opt.ignorecase = true
opt.incsearch = true -- 搜索时高亮

opt.autoindent = true -- 根据前一行进行缩进
opt.copyindent = true
opt.shiftwidth = 4
opt.softtabstop = 4 -- Tab键替换空格数
opt.tabstop = 4
opt.expandtab = true -- 使用空格键替换tabs
opt.smartindent = true
opt.smarttab = true

opt.list = true -- 显示不可打印的字符
opt.listchars = 'tab:»·,trail:·,nbsp:·'

opt.undofile = true
opt.backup = true
opt.swapfile = false
opt.ruler = true
opt.undolevels = 1000
opt.updatetime = 100 -- default updatetime 4000ms is not good for async update (vim/signify)
opt.backspace = 'indent,eol,start' -- 使 backspace 按您预期的方式工作
opt.clipboard = 'unnamedplus'
opt.shell = 'zsh'

vim.cmd[[
if has("nvim")
    set undodir=$HOME/.cache/nvim/undo
    set backupdir=$HOME/.cache/nvim/backup
else
    set undodir=$HOME/.cache/vim/undo
    set backupdir=$HOME/.cache/vim/backup
endif
]]

vim.cmd[[
if !isdirectory(&undodir)
  call mkdir(&undodir, 'p')
endif
if !isdirectory(&backupdir)
  call mkdir(&backupdir, 'p')
endif
]]

-- 高亮配置
g.Illuminate_delay = 300
g.Illuminate_ftblacklist = {'nerdtree', 'netrw'}
vim.cmd[[
hi Pmenu ctermfg=white ctermbg=238
]]

-- markdown 高亮设置
g.vim_markdown_math = 1
g.vim_markdown_conceal = 0
g.vim_markdown_conceal_code_blocks = 0
g.vim_markdown_strikethrough = 1
g.vim_markdown_new_list_item_indent = 2
g.vim_markdown_frontmatter = 1
g.tex_conceal = ''
g.markdown_fenced_languages = {
    'css',
    'erb=eruby',
    'javascript',
    'js=javascript',
    'jsx=javascriptreact',
    'ts=typescript',
    'tsx=typescriptreact',
    'json=jsonc',
    'ruby',
    'sass',
    'scss=sass',
    'xml',
    'html',
    'py=python',
    'python',
    'clojure',
    'clj=clojure',
    'cljs=clojure',
    'stylus=css',
    'less=css',
    'viml=vim'
}

-- Limelight 设置
g.limelight_conceal_ctermfg = 'gray'
g.limelight_conceal_ctermfg = 240
g.limelight_conceal_guifg = 'DarkGray'
g.limelight_conceal_guifg = '#777777'
g.limelight_default_coefficient = 0.7
vim.cmd[[
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
]]

-- bibcite 设置
g.bibtexcite_bibfile = '~/paperbib/mybib.bib'
g.bibtexcite_floating_window_border = {'│', '─', '╭', '╮', '╯', '╰'}
g.bibtexcite_close_preview_on_insert = 1

vim.cmd[[
let g:fzf_wordnet_preview_arg = ''
]]

-- 文件格式设置
vim.cmd[[
autocmd BufRead,BufNewFile *.tex set filetype=tex
autocmd BufRead,BufNewFile *.md set filetype=markdown
autocmd BufRead,BufNewFile *.tp set filetype=type
autocmd BufRead,BufNewFile *.m set filetype=matlab
]]

-- spell 设置
vim.cmd[[
set spellfile=$HOME/.config/nvim/spell/en.utf-8.add
set complete+=kspell
]]

-- 拼写检测
vim.cmd[[
autocmd FileType markdown setlocal spell
autocmd FileType gitcommit setlocal spell
]]

vim.cmd[[
" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
]]
