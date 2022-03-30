local g = vim.g
local opt = vim.opt

-- vim.cmd('silent! colorscheme neon')
vim.cmd('syntax on') -- 打开语法高亮
vim.cmd('filetype plugin indent on') -- 根据检测到文件类型加载插件

-- Stop loading built in plugins
g.loaded_gzip = 1
g.loaded_man = 1
g.loaded_matchit = 1
g.loaded_matchparen = 1
g.loaded_netrwPlugin = 1
g.loaded_tarPlugin = 1
g.loaded_2html_plugin = 1
g.loaded_zipPlugin = 1
g.loaded_remote_plugins = 1
g.loaded_shada_plugin = 1

g.loaded_node_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
g.loaded_python3_provider = 0

g.do_filetype_lua = 1

-- search
opt.hlsearch = true -- 保持匹配项目高亮
opt.smartcase = true
opt.ignorecase = true
opt.incsearch = true -- 搜索时高亮
opt.autoindent = true -- 根据前一行进行缩进
opt.copyindent = true

-- indention & tab
opt.shiftwidth = 4
opt.softtabstop = 4 -- Tab键替换空格数
opt.tabstop = 4
opt.expandtab = true -- 使用空格键替换tabs
opt.smartindent = true
opt.smarttab = true

opt.list = true -- 显示不可打印的字符
opt.listchars = 'tab:»·,trail:·,nbsp:·'

-- backups
opt.undofile = true
opt.backup = true
opt.swapfile = false
opt.ruler = true
opt.undolevels = 1000
opt.updatetime = 100 -- default updatetime 4000ms is not good for async update (vim/signify)
opt.backspace = 'indent,eol,start' -- 使 backspace 按您预期的方式工作
opt.clipboard = 'unnamedplus'
opt.shell = 'zsh'

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
opt.cursorline = true -- 快速找到当前行

g.user_emmet_settings = {
    javascript = {extends = 'jsx'},
    typescript = {extends = 'tsx'}
}
opt.complete = ''
g.rainbow_active = 1
g.neon_style = 'doom'
g.EasyMotion_do_mapping = 0
g.EasyMotion_smartcase = 1
g.swoopAutoInsertMode = 1
-- g.rust_clip_command = 'pbcopy'
-- g.python3_host_prog = '~/.pyenv/versions/nvim-py3/bin/python'
g.user_emmet_install_global = 0
 -- gf 自定义
g.GfList_map_n_gf = 'gf'
g.GfList_map_v_gf = 'gf'

vim.cmd[[
let g:gtfo#terminals = { 'unix': 'st -e nvim' }
]]

vim.cmd[[
autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline
]]

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

vim.cmd[[
hi Pmenu ctermfg=white ctermbg=238
]]

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

-- 保存前格式化

vim.cmd[[
" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
]]
