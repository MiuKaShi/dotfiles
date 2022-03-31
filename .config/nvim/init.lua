require('plugins') -- 插件list
require('functions')
require('general') -- 全局设置
require('keymaps') -- 键位映射关系
require('lsp')

-- %%%%%%%%%%%%%%%%%
-- 自定义字段
-- %%%%%%%%%%%%%%%%%
vim.opt.termguicolors = true
vim.g.gruvbox_transparent_bg = true
vim.cmd([[colorscheme gruvbox]])
vim.cmd([[hi Normal ctermbg=NONE guibg=NONE]])
