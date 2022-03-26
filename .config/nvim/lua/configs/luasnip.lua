local ls = require('luasnip')
local types = require('luasnip.util.types')

ls.config.setup{
    -- Allow resuming snippets
    history = true,
    -- Update dynamic ssnippets as you type
    updateevents = "TextChanged,TextChangedI",
    enable_autosnippets = true,
    ext_opts = {
        [types.choiceNode] = {
            active = {
                -- virt_text = { { '●', 'DiagnosticSignHint' } },
                -- virt_text = { { '◍', 'DiagnosticSignHint' } },
                virt_text = {{'<-', 'Error'}}
            }
        }
    }
}
require('luasnip.loaders.from_vscode').lazy_load({
    paths = {'~/.config/nvim/snippets'}
})

