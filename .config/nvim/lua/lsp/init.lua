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
    filetypes = {'c', 'cpp', 'cc'},
    flags = {debounce_text_changes = 150}
}

-- cssls
lspconfig.cssls.setup{
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = {'vscode-css-languageserver', '--stdio'},
    flags = {debounce_text_changes = 150}
}

-- yamlls
lspconfig.yamlls.setup{
    on_attach = on_attach,
    settings = {
        yaml = {
            schemas = {
                ['https://cfn-schema.y13i.com/schema?region=eu-west-2&version=20.0.0'] = 'cloudformation/*',
                ['http://json.schemastore.org/github-workflow'] = '.github/workflows/*'
            },
            format = {enable = false},
            completion = true,
            hover = true,
            customTags = {
                '!And scalar',
                '!And mapping',
                '!And sequence',
                '!Condition scalar',
                '!Condition mapping',
                '!Condition sequence',
                '!Base64 scalar',
                '!Base64 mapping',
                '!Base64 sequence',
                '!If scalar',
                '!If mapping',
                '!If sequence',
                '!Not scalar',
                '!Not mapping',
                '!Not sequence',
                '!Equals scalar',
                '!Equals mapping',
                '!Equals sequence',
                '!Or scalar',
                '!Or mapping',
                '!Or sequence',
                '!FindInMap scalar',
                '!FindInMap mappping',
                '!FindInMap sequence',
                '!Base64 scalar',
                '!Base64 mapping',
                '!Base64 sequence',
                '!Cidr scalar',
                '!Cidr mapping',
                '!Cidr sequence',
                '!Ref scalar',
                '!Ref mapping',
                '!Ref sequence',
                '!Sub scalar',
                '!Sub mapping',
                '!Sub sequence',
                '!GetAtt scalar',
                '!GetAtt mapping',
                '!GetAtt sequence',
                '!GetAZs scalar',
                '!GetAZs mapping',
                '!GetAZs sequence',
                '!ImportValue scalar',
                '!ImportValue mapping',
                '!ImportValue sequence',
                '!Select scalar',
                '!Select mapping',
                '!Select sequence',
                '!Split scalar',
                '!Split mapping',
                '!Split sequence',
                '!Join scalar',
                '!Join mapping',
                '!Join sequence'
            }
        }
    }
}

-- jsonls
lspconfig.jsonls.setup{
    on_attach = function(client)
        client.resolved_capabilities.document_formatting = false
        on_attach(client)
    end,
    cmd = {'vscode-json-languageserver', '--stdio'},
    settings = {
        json = {
            format = {enable = false},
            schemaDownload = {enable = true},
            schemas = {
                {
                    description = 'AWS IAM configuration',
                    fileMatch = {'iam/*.json'},
                    url = 'https://gist.githubusercontent.com/jstewmon/ee5d4b7ec0d8d60cbc303cb515272f8a/raw/fc6977788b85ea52e9acad0347287516157b5865/aws-iam-poilcy-schema.json'
                }
            }
        }
    }
}

-- bash
lspconfig.bashls.setup{on_attach = on_attach, capabilities = capabilities}

-- Python language server
lspconfig.pyright.setup{on_attach = on_attach, capabilities = capabilities}

-- vimls
lspconfig.vimls.setup{on_attach = on_attach, capabilities = capabilities}

-- lua
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

lspconfig.sumneko_lua.setup({
    on_attach = on_attach,
    settings = {
        Lua = {
            runtime = {version = 'LuaJIT', path = runtime_path},
            diagnostics = {globals = {'vim'}},
            workspace = {library = vim.api.nvim_get_runtime_file('', true)},
            telemetry = {enable = false}
        }
    },
    capabilities = capabilities
})

-- Linters and formatters (efm-lang-server)
local prettier = function(parameters)
    parameters = parameters or ''
    return {
        formatCommand = 'prettier --stdin-filepath ${INPUT} ' .. parameters,
        formatStdin = true
    }
end
lspconfig.efm.setup{
    on_attach = on_attach,
    capabilities = capabilities,
    init_options = {documentFormatting = true},
    filetypes = {
        'json',
        'java',
        'yaml',
        'sh',
        'matlab',
        'markdown',
        'lua',
        'python'
    },
    settings = {
        rootMarkers = {'.git/'},
        languages = {
            java = {prettier()},
            json = {prettier()},
            yaml = {
                prettier('--single-quote'),
                {
                    lintCommand = 'yamllint -f parsable -',
                    lintStdin = true,
                    lintFormats = {'%f:%l %m'}
                }
            },
            sh = {
                {
                    formatCommand = 'shfmt -filename ${INPUT}',
                    formatStdin = true,
                    lintCommand = 'shellcheck -f gcc -x',
                    lintSource = 'shellcheck'
                }
            },
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
            markdown = {
                {
                    lintCommand = 'markdownlint -s -c ${HOME}/.config/.markdownlintrc',
                    lintStdin = true,
                    lintFormats = {'%f:%l %m', '%f:%l:%c %m', '%f: %l: %m'}
                }
            },
            lua = {{formatCommand = 'lua-format -i', formatStdin = true}},
            python = {{formatCommand = 'yapf --quiet', formatStdin = true}}
        }
    }
}
