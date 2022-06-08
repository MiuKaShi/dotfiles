vim.cmd [[
function! g:Open_browser(url)
    silent exec "!st -e surf " . a:url . " &"
endfunction
]]

vim.g.mkdp_browserfunc = 'g:Open_browser'
vim.g.mkdp_page_title = '${name}.md'
vim.g.mkdp_filetypes = {'markdown'}
vim.g.mkdp_preview_options = {
  -- ['sync_scroll_type'] = 'relative',
  ['hide_yaml_meta'] = 1,
}
