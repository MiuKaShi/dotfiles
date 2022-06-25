require('plugins') -- 插件list
require('functions')
require('general') -- 全局设置
require('keymaps') -- 键位映射关系
require('lsp')

-- %%%%%%%%%%%%%%%%%
-- 主题设置
-- %%%%%%%%%%%%%%%%%
vim.g.gruvbox_contrast_dark = "hard"
vim.cmd 'colorscheme gruvbox'
vim.cmd [[hi Normal guibg=NONE ctermbg=NONE]]
vim.cmd [[hi NonText guibg=NONE ctermbg=NONE]]
vim.cmd [[hi EndOfBuffer guibg=NONE ctermbg=NONE]]
vim.cmd [[hi SignColumn guibg=NONE ctermbg=NONE]]
vim.cmd [[hi Pmenu guibg=NONE ctermbg=NONE]]
