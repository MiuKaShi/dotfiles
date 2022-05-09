-- 1.自动对齐
vim.g.neoformat_basic_format_align = 1
-- 2.自动删除行尾空格
vim.g.neoformat_basic_format_trim = 1
-- 3.将制表符替换为空格
vim.g.neoformat_basic_format_retab = 1
-- 只提示错误消息
vim.g.neoformat_only_msg_on_error = 1

vim.g.neoformat_enabled_markdown = {'prettier'}
vim.g.neoformat_enabled_html = {'prettier'}
vim.g.neoformat_enabled_json = {'prettier'}
vim.g.neoformat_enabled_yaml = {'prettier'}
-- vim.g.neoformat_enabled_yaml = {'yamlfmt'}
-- sh
vim.g.neoformat_enabled_sh = {'shfmt'}
vim.g.shfmt_opt = '-i 4 -ci -bn' -- google style sh
-- lua
vim.g.neoformat_enabled_lua = {'luaformat'}
-- python
vim.g.neoformat_enabled_python = {'black'}
-- C family
vim.g.neoformat_enabled_cpp = {'uncrustify'}
vim.g.neoformat_enabled_c = {'uncrustify'}

-- uncrustify setting
vim.g.neoformat_c_uncrustify = {
    exe = 'uncrustify',
    args = {'-l C', '-c ~/.config/nvim/linux-indent.cfg', '-q', '-f'}
}
vim.g.neoformat_cpp_uncrustify = {
    exe = 'uncrustify',
    args = {'-l CPP', '-c ~/.config/nvim/linux-indent.cfg', '-q', '-f'}
}

-- clang-format setting
-- vim.g.neoformat_c_clangformat = {
--     exe = 'clang-format',
--     args = {
--         '--style="{BasedOnStyle: LLVM, IndentWidth: 8, UseTab: Always, BreakBeforeBraces: Linux, AllowShortIfStatementsOnASingleLine: false, IndentCaseLabels: false, AllowShortBlocksOnASingleLine: Never }"'
--     }
-- }
-- vim.g.neoformat_cpp_clangformat = {
--     exe = 'clang-format',
--     args = {
--         '-style="{BasedOnStyle: GNU, AccessModifierOffset: 0, AlignConsecutiveMacros: AcrossEmptyLinesAndComments, AllowShortBlocksOnASingleLine: Always, AlwaysBreakAfterDefinitionReturnType: None, AlwaysBreakAfterReturnType: None, AlwaysBreakTemplateDeclarations: Yes, BreakBeforeBinaryOperators: None, BreakBeforeBraces: Allman, BreakInheritanceList: AfterComma, BreakConstructorInitializers: AfterColon, ConstructorInitializerIndentWidth: 2, ContinuationIndentWidth: 2, IndentAccessModifiers: true, IndentCaseBlocks: true, SpaceAfterTemplateKeyword: false, SpaceBeforeParens: Never, SpaceBeforeRangeBasedForLoopColon: false, Standard: Latest, TabWidth: 2}"'
--     }
-- }

vim.cmd[[
augroup fmt
autocmd!
autocmd BufWritePre *.sh Neoformat
autocmd BufWritePre *.py Neoformat
autocmd BufWritePre *.lua Neoformat
autocmd BufWritePre *.m Neoformat
autocmd BufWritePre *.md Neoformat
autocmd BufWritePre *.json, yaml,*.yml Neoformat
autocmd BufWritePre *.c,*.h,*.cc,*.hh,*.cpp,*.hpp Neoformat
augroup END
]]
