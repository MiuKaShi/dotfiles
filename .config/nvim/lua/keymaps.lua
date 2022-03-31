local set_keymap = vim.api.nvim_set_keymap

vim.g.mapleader = ' '

local function _map(mode, shortcut, command)
    set_keymap(mode, shortcut, command, {noremap = true, silent = true})
end

local function map(shortcut, command)
    _map('', shortcut, command)
end

local function nmap(shortcut, command)
    _map('n', shortcut, command)
end

local function imap(shortcut, command)
    _map('i', shortcut, command)
end

local function vmap(shortcut, command)
    _map('v', shortcut, command)
end

local function cmap(shortcut, command)
    _map('c', shortcut, command)
end

local function tmap(shortcut, command)
    _map('t', shortcut, command)
end

-- Setup for emacs keybindings
-- insert mode
set_keymap('i', '<C-a>', '<Esc>0i', {})
set_keymap('i', '<C-e>', '<End>', {})
set_keymap('i', '<C-d>', '<Del>', {})
set_keymap('i', '<C-c>', '<C-r>=KillLine()<CR>', {})
set_keymap('i', '<C-n>', '<Plug>(fzf-complete-wordnet)', {}) -- dicitonal

-- normal mode
set_keymap('n', '<C-l>', ':bnext<CR>', {}) -- buffer 跳转
set_keymap('n', '<C-h>', ':bprev<CR>', {})
set_keymap('n', '<C-s>', ':w<CR>', {}) -- save file
set_keymap('n', '<C-e>', ':Lf<CR>', {}) -- file tree
set_keymap('n', '<C-w>', ':bdelete<CR>', {}) -- file tree

-- command line mode
set_keymap('c', '<C-a>', '<Home>', {})
set_keymap('c', '<C-e>', '<End>', {})
-- C-d 本身表示显示详情，可用命令
-- set_keymap('c', '<C-d>', '<Del>', {})
set_keymap('c', '<C-h>', '<BS>', {noremap = true})
set_keymap('c', '<C-k>', '<C-f>D<C-c><C-c>:<Up>', {noremap = true})
-- End of setup for emacs keybindings

-- lspconfig 服务地址 https://github.com/neovim/nvim-lspconfig
nmap('gd', '<cmd>lua vim.lsp.buf.definition()<CR>') -- 跳转定义
nmap('J', '<cmd>lua require\'lspsaga.provider\'.preview_definition()<CR>') -- 预览定义
nmap('K', '<cmd>lua require(\'lspsaga.hover\').render_hover_doc()<CR>') -- 显示文档定义
nmap('<C-n>',
 '<cmd>lua require(\'lspsaga.action\').smart_scroll_with_saga(1)<CR>') -- 滚动hover 下
nmap('<C-p>',
 '<cmd>lua require(\'lspsaga.action\').smart_scroll_with_saga(-1)<CR>') -- 滚动hover 上
nmap('<C-f>', '<cmd>Telescope find_files<CR>') -- 查找文件
nmap('gF', ':Telescope live_grep<CR>') -- 模糊查找文件
nmap('gs', '<cmd>lua require(\'lspsaga.signaturehelp\').signature_help()<CR>') -- 签名查看
nmap('gS', '<cmd>lua require\'lspsaga.diagnostic\'.show_line_diagnostics()<CR>') -- 诊断问题
nmap('gi', '<cmd>lua vim.lsp.buf.implementation()<CR>'); -- 跳转实现
nmap('gn', ':BufferLineCycleNext<CR>'); -- 下一个文件
nmap('gp', ':BufferLineCyclePrev<CR>'); -- 上一个文件
nmap('gr', '<cmd>lua require(\'lspsaga.rename\').rename()<CR>') -- 重命名
nmap('ca', '<cmd>lua require(\'lspsaga.codeaction\').code_action()<CR>') -- 代码操作
vmap('ca', ':<C-U>lua require(\'lspsaga.codeaction\').range_code_action()<CR>') -- 选中的代码操作
nmap('gh', '<cmd>lua require\'lspsaga.provider\'.lsp_finder()<CR>') -- 异步查找单词定义、引用
tmap('<ESC>', '<C-\\><C-n>:Lspsaga close_floaterm<CR>') -- 关闭终端
-- set_keymap('n', 's', '<Plug>(easymotion-overwin-f)', {})
set_keymap('n', '<leader>;;', 'gcc', {})
set_keymap('v', '<leader>;', 'gcc<esc>', {})

-- bibcite 快捷键
vim.cmd[[
autocmd FileType markdown inoremap <buffer> <silent> @@ <Esc>:BibtexciteInsert<CR>
]]

vim.cmd[[
au FileType html,typescriptreact,javascriptreact EmmetInstall
au FileType html,gohtmltmpl,typescriptreact,javascriptreact imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")
]]

-- 保存前格式化

-- vim.cmd [[
--   autocmd BufWritePre *.rs,*.js,*.ts,*.jsx,*.tsx,*.json,*.yaml,*.toml,*.html,*.css,*.less,*.sass :lua vim.lsp.buf.formatting_sync(nil, 200)<CR>
-- ]]
