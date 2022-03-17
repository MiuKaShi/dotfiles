require('plugins') -- 插件list
require('functions')
require('general') -- 全局设置
require('mappings') -- 键位映射关系
require('lsp')

-- %%%%%%%%%%%%%%%%%
-- 自定义字段
-- %%%%%%%%%%%%%%%%%

-- 主题
vim.cmd[[
autocmd vimenter * ++nested colorscheme gruvbox
autocmd VimEnter * hi Normal ctermbg=NONE guibg=NONE
]]

-- 设置全局的option值
-- vim.api.nvim_set_option('tabpagemax', 8)

-- 键位映射
vim.cmd[[
  noremap j gj
  nnoremap k gk
]]

