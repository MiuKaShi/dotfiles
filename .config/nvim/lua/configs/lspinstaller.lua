local utils = require('utils')

local capabilities = vim.lsp.protocol.make_client_capabilities()
utils.safe_require('cmp_nvim_lsp', function(cmp_nvim_lsp)
    capabilities = cmp_nvim_lsp.update_capabilities(capabilities)
end)
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
end

-- Setup for nvim-lsp-installer
utils.safe_require('nvim-lsp-installer', function(lsp_installer)
    local opt = {
        capabilities = capabilities,
        on_attach = on_attach,
        flags = {debounce_text_changes = 150}
    }
    lsp_installer.on_server_ready(function(server)
        if server.name == 'sumneko_lua' then
            opt = utils.safe_require('lua-dev', function(luadev)
                local opt_ = luadev.setup()
                return vim.tbl_deep_extend('force', opt_, opt)
            end) or opt
        end
        server:setup(opt)
    end)
end)
-- End of setup for nvim-lsp-installer

