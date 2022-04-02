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

require('lspconfig').ltex.setup({
    cmd = {'/usr/bin/ltex-ls'},
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = {
        'bib',
        'gitcommit',
        'markdown',
        'org',
        'plaintex',
        'rst',
        'rnoweb',
        'tex'
    },
    settings = {
        ltex = {
            dictionary = {
                -- Couldn't make this work, unfortunately, so added `MORFOLOGIK_RULE_EN_US`.
                ['en-US'] = {[[:~/.config/nvim/spell/en.utf-8.add]]}
            },
            additionalRules = {motherTongue = 'it'},
            disabledRules = {
                ['en-US'] = {'WHITESPACE_RULE', 'MORFOLOGIK_RULE_EN_US'}
            },
            markdown = {
                nodes = {
                    CodeBlock = 'ignore',
                    FencedCodeBlock = 'ignore',
                    AutoLink = 'dummy',
                    Code = 'dummy'
                }
            }
        }
    }
})

-- go lsp
lspconfig.gopls.setup{
    capabilities = capabilities,
    on_attach = on_attach,
    flags = {debounce_text_changes = 150}
}

-- c lsp
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

-- yamlls lsp
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

-- json lsp
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

-- bash lsp
lspconfig.bashls.setup{on_attach = on_attach, capabilities = capabilities}

-- Python lsp
lspconfig.pyright.setup{on_attach = on_attach, capabilities = capabilities}

-- vim lsp
lspconfig.vimls.setup{on_attach = on_attach, capabilities = capabilities}

-- sumneko lua
local luadev = require('lua-dev').setup{
    lspconfig = {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {Lua = {diagnostics = {globals = {'vim', 'use'}}}}
    }
}
lspconfig.sumneko_lua.setup(luadev)

-- Linters and formatters (efm-lang-server)
local prettier = require'lsp.efm.prettier'
local yamlfmt = require'lsp.efm.yamlfmt'
local shfmt = require'lsp.efm.shfmt'
local luafmt = require'lsp.efm.luafmt'
local yapf = require'lsp.efm.yapf'
local markdownfmt = require'lsp.efm.markdownfmt'
local matlabfmt = require'lsp.efm.matlabfmt'

local languages = {
    java = {prettier},
    json = {prettier},
    yaml = {yamlfmt},
    sh = {shfmt},
    matlab = {matlabfmt},
    markdown = {markdownfmt},
    lua = {luafmt},
    python = {yapf}
}

lspconfig.efm.setup{
    on_attach = on_attach,
    capabilities = capabilities,
    init_options = {documentFormatting = true},
    filetypes = vim.tbl_keys(languages),
    settings = {
        rootMarkers = {'.git/'},
        languages = languages,
        log_level = 1,
        log_file = '~/efm.log'
    }
}
