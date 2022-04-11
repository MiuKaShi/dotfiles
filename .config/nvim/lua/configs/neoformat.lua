vim.g.neoformat_enabled_markdown = {'prettier'}
vim.g.neoformat_enabled_html = {'prettier'}
vim.g.neoformat_enabled_json = {'prettier'}
vim.g.neoformat_enabled_yaml = {'prettier'}
-- vim.g.neoformat_enabled_yaml = {'yamlfmt'}
-- sh
vim.g.neoformat_enabled_sh = {'shfmt'}
vim.g.shfmt_opt = '-ci'
-- lua
vim.g.neoformat_enabled_lua = {'luaformat'}
-- python
vim.g.neoformat_enabled_python = {'black'}

vim.cmd[[
augroup fmt
autocmd!
autocmd BufWritePre *.sh Neoformat
autocmd BufWritePre *.py Neoformat
autocmd BufWritePre *.lua Neoformat
autocmd BufWritePre *.m Neoformat
autocmd BufWritePre *.md Neoformat
autocmd BufWritePre *.json, yaml,*.yml Neoformat
augroup END
]]
