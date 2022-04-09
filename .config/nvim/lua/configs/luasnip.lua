local ls = require('luasnip')
local types = require('luasnip.util.types')

ls.config.setup{
    -- Update dynamic ssnippets as you type
    updateevents = 'TextChanged,TextChangedI',
    enable_autosnippets = true,
    ext_opts = {
        [types.choiceNode] = {
            active = {virt_text = {{'<- Current Choice', 'NonText'}}}
        }
        -- [types.insertNode] = {
        -- 	active = {
        -- 		virt_text = { { '◍', 'DiagnosticSignHint' } },
        -- 	},
        -- },
    }
}

require('luasnip.loaders.from_lua').lazy_load({
    paths = {'~/.config/nvim/luasnippets'}
})
