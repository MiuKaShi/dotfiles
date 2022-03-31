local utils = require('utils')

-- Setup for nvim-cmp.
utils.safe_require({'cmp', 'lspkind'}, function(cmp, lspkind)
    cmp.event:on('confirm_done')
    local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and
                vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col,
                 col):match('%s') == nil
    end

    local tab_complete = function(fallback)
        if cmp.visible() then
            cmp.select_next_item()
        else
            fallback()
        end
    end

    local s_tab_complete = function(fallback)
        if cmp.visible() then
            cmp.select_prev_item()
        elseif has_words_before() then
            cmp.complete()
        else
            fallback()
        end
    end

    cmp.setup({
        snippet = {
            -- REQUIRED - you must specify a snippet engine
            expand = function(args)
                -- vim.fn['vsnip#anonymous'](args.body) -- For `vsnip` users.
                require('luasnip').lsp_expand(args.body)
                -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
                -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
            end
        },
        formatting = {
            format = function(entry, vim_item)
                vim_item.kind = lspkind.presets.default[vim_item.kind]
                local menu = ({
                    nvim_lsp = '[LSP]',
                    nvim_lua = '[API]',
                    cmp_octave = '[OCTAVE]',
                    cmp_matlab = '[MATLAB]',
                    path = '📁',
                    cmp_tabnine = '[Tabnine]',
                    luasnip = '🔥',
                    spell = '暈',
                    calc = '[Calc]',
                    buffer = '[Buffer]'
                })[entry.source.name]
                if entry.source.name == 'cmp_tabnine' then
                    if entry.completion_item.data ~= nil and
                     entry.completion_item.data.detail ~= nil then
                        menu = entry.completion_item.data.detail .. ' ' .. menu
                    end
                    vim_item.kind = ''
                end
                vim_item.menu = menu
                return vim_item
            end
        },
        experimental = {ghost_text = true},
        documentation = {
            border = {'╭', '─', '╮', '│', '╯', '─', '╰', '│'}
        },
        mapping = {
            ['<C-j>'] = cmp.mapping.select_next_item(),
            ['<C-k>'] = cmp.mapping.select_prev_item(),
            ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), {'i', 'c'}),
            ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), {'i', 'c'}),
            ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), {'i', 'c'}),
            ['<Tab>'] = tab_complete,
            ['<S-Tab>'] = s_tab_complete,
            ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
            ['<C-e>'] = cmp.mapping({
                i = cmp.mapping.abort(),
                c = cmp.mapping.close()
            }),
            ['<CR>'] = cmp.mapping.confirm({select = true}) -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        },
        sources = cmp.config.sources({{name = 'nvim_lsp'}, {name = 'luasnip'}},
         {
             {name = 'buffer', keyword_length = 4}, -- for buffer word completion
             {name = 'path'},
             {name = 'cmp_matlab'},
             {name = 'cmp_tabnine'},
             {name = 'nvim_lua'}
             -- {name = 'cmp_octave'}
         })
    })

    cmp.setup.filetype('norg', {
        sources = {
            {name = 'luasnip'},
            {name = 'neorg'},
            {name = 'buffer', keyword_length = 3}
        }
    })
    -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline('/', {sources = {{name = 'buffer'}}})

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(':', {
        sources = cmp.config.sources({{name = 'path'}}, {{name = 'cmdline'}})
    })
end)
-- End of setup for nvim-cmp.
