local g = vim.g
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

