require('plugins') -- 插件list
require('functions')
require('general') -- 全局设置
require('keymaps') -- 键位映射关系
require('lsp')

-- %%%%%%%%%%%%%%%%%
-- 主题设置
-- %%%%%%%%%%%%%%%%%
vim.opt.termguicolors = true
vim.g.gruvbox_transparent_bg = true
vim.opt.background = "dark"
vim.cmd [[colorscheme gruvbox]]
vim.cmd [[hi Normal guibg=NONE ctermbg=NONE]]
vim.cmd [[hi NonText guibg=NONE ctermbg=NONE]]
vim.cmd [[hi EndOfBuffer guibg=NONE ctermbg=NONE]]

