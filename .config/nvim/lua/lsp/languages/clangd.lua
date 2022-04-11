local M = {}

M.setup = function(on_attach, capabilities)
    require('lspconfig').bashls.setup{
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = {'c', 'cpp', 'cc'},
        flags = {debounce_text_changes = 150}
    }
end

return M
