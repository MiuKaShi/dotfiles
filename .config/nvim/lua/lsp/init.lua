-- Snippets support
local lspconfig = require'lspconfig'
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true;
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {'documentation', 'detail', 'additionalTextEdits'}
}

-- Diagnostics symbols for display in the sign column.
local signs = {Error = ' ', Warn = ' ', Hint = ' ', Info = ' '}
for type, icon in pairs(signs) do
    local hl = 'DiagnosticSign' .. type
    vim.fn.sign_define(hl, {text = icon, texthl = hl, numhl = hl})
end

local on_attach = function(client, bufnr)
    local function set(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    set('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec([[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
    end
end

-- LSP servers

-- go
lspconfig.gopls.setup{
    capabilities = capabilities,
    on_attach = on_attach,
    flags = {debounce_text_changes = 150}
}

-- c
lspconfig.clangd.setup{
    capabilities = capabilities,
    on_attach = on_attach,
    flags = {debounce_text_changes = 150}
}

-- bash
lspconfig.bashls.setup{on_attach = on_attach, capabilities = capabilities}

-- Python language server
lspconfig.pyright.setup{on_attach = on_attach, capabilities = capabilities}

-- vimls
lspconfig.vimls.setup{on_attach = on_attach, capabilities = capabilities}

-- Linters and formatters (efm-lang-server)
lspconfig.efm.setup{
    on_attach = on_attach,
    capabilities = capabilities,
    init_options = {documentFormatting = true},
    filetypes = {
        'matlab',
        'fish',
        'lua',
        'python',
        'pandoc'
    },
    settings = {
        rootMarkers = {'.git/'},
        languages = {
            matlab = {
                {
                    lintCommand = '/usr/bin/mlint -severity',
                    lintStdin = false,
                    lintStderr = true,
                    lintIgnoreExitCode = true,
                    lintFormats = {
                        'L %l (C %c): ML%t: %m',
                        'L %l (C %c-%*[0-9]): ML%t: %m'
                    },
                    lintCategoryMap = { -- Severities
                        ['0'] = 'I',
                        ['1'] = 'W',
                        ['2'] = 'W',
                        ['3'] = 'E'
                    }
                }
            },
            fish = {
                {
                    lintCommand = '/usr/bin/fish -n',
                    lintStdin = false,
                    lintStderr = true,
                    lintFormats = {'%f (line %l): %m'}
                }
            },
            pandoc = {
                {
                    lintCommand = 'markdownlint -s',
                    lintStdin = true,
                    lintFormats = {'%f:%l %m', '%f:%l:%c %m', '%f: %l: %m'},
                    formatCommand = 'pandoc -f markdown -t markdown -sp --tab-stop=2'
                }
            },
            lua = {{formatCommand = 'lua-format -i', formatStdin = true}},
            python = {{formatCommand = 'yapf --quiet', formatStdin = true}}
        }
    }
}
