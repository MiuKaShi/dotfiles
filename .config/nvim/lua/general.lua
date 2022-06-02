local g   = vim.g
local opt = vim.opt
local wo  = vim.wo

-- vim.cmd('silent! colorscheme neon')
vim.cmd 'syntax on' -- 打开语法高亮
vim.cmd 'filetype plugin indent on' -- 根据检测到文件类型加载插件

-- TURN OFF SOME BUILTIN PLUGINS
vim.g.loaded_2html_plugin      = 1
vim.g.loaded_gzip              = 1
vim.g.loaded_matchit           = 1
vim.g.loaded_matchparen        = 1
vim.g.loaded_netrw             = 1
vim.g.loaded_netrwFileHandlers = 1
vim.g.loaded_netrwPlugin       = 1
vim.g.loaded_netrwSettings     = 1
vim.g.loaded_tar               = 1
vim.g.loaded_tarPlugin         = 1
vim.g.loaded_vimball           = 1
vim.g.loaded_vimballPlugin     = 1
vim.g.loaded_zip               = 1
vim.g.loaded_zipPlugin         = 1

-- DISABLE REMOTE PLUGINS
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider    = 0
vim.g.loaded_node_provider    = 0
vim.g.loaded_perl_provider    = 0

vim.g.do_filetype_lua    = 1
vim.g.did_load_filetypes = 0

-- minimal working config
opt.relativenumber = true -- Show relative line numbers
opt.number         = true
opt.textwidth      = 120 -- Line wrap (number of cols)
opt.linebreak      = true
opt.showbreak      = '> '
opt.title          = true

-- search
opt.hlsearch   = true -- 保持匹配项目高亮
opt.smartcase  = true
opt.ignorecase = true
opt.incsearch  = true -- 搜索时高亮
opt.copyindent = true

-- indention & tab
opt.tabstop     = 4 -- Ensure files with tabs look the same
opt.shiftwidth  = 4 -- Number of auto-indent spaces
opt.expandtab   = true -- Use spaces instead of tabs
opt.softtabstop = -1 -- Number of spaces per <Tab> (use value of sw)
opt.smarttab    = true -- Enable smart-tabs (<Tab> will always use sw)

opt.autoindent  = true -- Auto-indent new lines
opt.smartindent = false -- Disable smart-indent
opt.pumheight   = 10

-- Hide bottom status
opt.laststatus = 0
opt.ruler      = false
opt.showmode   = false
opt.showcmd    = false

-- backups
opt.undofile   = true
opt.backup     = true
opt.swapfile   = false
opt.undolevels = 1000
opt.updatetime = 100 -- default updatetime 4000ms is not good for async update (vim/signify)
opt.backspace  = 'indent,eol,start' -- 使 backspace 按您预期的方式工作
opt.clipboard  = 'unnamedplus'
opt.shell      = 'zsh'
--
opt.timeoutlen              = 500
opt.go                      = 'a'
opt.mouse                   = 'a'
opt.encoding                = 'UTF-8'
opt.fileencoding            = 'UTF-8'
opt.fileencodings           = 'UTF-8'
opt.termguicolors           = true
opt.lazyredraw              = true -- Speeds up scrolling
opt.redrawtime              = 10000
opt.regexpengine            = 1
opt.scrolloff               = 8 -- Always show at least one line above/below the cursor.
opt.showmatch               = true
opt.visualbell              = true
-- opt.cursorline              = true -- 高亮当前行
opt.whichwrap               = 'b,s,<,>,[,]'
g.user_emmet_settings       = {
    javascript = { extends = 'jsx' },
    typescript = { extends = 'tsx' },
}
-- Set completeopt to have a better completion experience
opt.completeopt             = 'menuone,noinsert,noselect'
g.rainbow_active            = 1
g.neon_style                = 'doom'
g.EasyMotion_do_mapping     = 0
g.EasyMotion_smartcase      = 1
g.swoopAutoInsertMode       = 1
g.user_emmet_install_global = 0
-- gf 自定义
g.GfList_map_n_gf           = 'gf'
g.GfList_map_v_gf           = 'gf'

vim.cmd [[
let g:gtfo#terminals = { 'unix': 'st -e nvim' }
]]

vim.cmd [[
autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline
]]

vim.cmd [[
if has("nvim")
    set undodir=$HOME/.cache/nvim/undo
    set backupdir=$HOME/.cache/nvim/backup
else
    set undodir=$HOME/.cache/vim/undo
    set backupdir=$HOME/.cache/vim/backup
endif
]]

vim.cmd [[
if !isdirectory(&undodir)
  call mkdir(&undodir, 'p')
endif
if !isdirectory(&backupdir)
  call mkdir(&backupdir, 'p')
endif
]]

vim.cmd [[
hi Pmenu ctermfg=white ctermbg=238
]]

vim.cmd [[
let g:fzf_wordnet_preview_arg = ''
]]

-- 文件格式设置
vim.cmd [[
autocmd BufRead,BufNewFile *.tex set filetype=tex
autocmd BufRead,BufNewFile *.tp set filetype=type
autocmd BufRead,BufNewFile *.m set filetype=matlab
autocmd BufRead,BufNewFile sxhkdrc,*.sxhkdrc set filetype=sxhkdrc
]]
