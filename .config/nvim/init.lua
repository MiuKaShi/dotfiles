require('plugins') -- 插件
require('functions')
require('settings')
require('config')
require('mappings') -- 键位映射关系
require('lsp')

-- %%%%%%%%%%%%%%%%%
-- 自定义字段
-- %%%%%%%%%%%%%%%%%

-- 主题
vim.cmd [[
autocmd vimenter * ++nested colorscheme gruvbox
autocmd VimEnter * hi Normal ctermbg=NONE guibg=NONE
]]
-- Lualine 主题
local lualine = require('lualine')
lualine.setup {
  options = {
    theme = 'pywal-nvim',
  },
}

-- 设置全局的option值
-- vim.api.nvim_set_option('tabpagemax', 8)

-- 键位映射
vim.cmd [[
  noremap j gj
  nnoremap k gk
]]


