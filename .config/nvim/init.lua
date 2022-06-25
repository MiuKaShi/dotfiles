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
vim.cmd [[
hi Normal ctermbg=NONE guibg=NONE
hi NonText ctermbg=NONE guibg=NONE
hi LineNR guibg=NONE ctermbg=NONE
hi CursorLineNR guibg=NONE ctermbg=NONE
hi SignColumn ctermbg=NONE guibg=NONE
hi MsgArea ctermbg=NONE guibg=NONE
hi Pmenu guibg=NONE ctermbg=NONE
hi EndOfBuffer guibg=NONE ctermbg=NONE
]]
