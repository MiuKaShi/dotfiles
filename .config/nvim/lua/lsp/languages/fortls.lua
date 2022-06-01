local M = {}

M.setup = function(on_attach, capabilities)
    require('lspconfig').fortls.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        cmd = { "fortls", "--enable_code_actions", "--hover_signature", "--variable_hover", "--lowercase_intrinsics"},
        filetypes = { 'fortran' },
        settings = { nthreads = 4 },
    }
end

return M
