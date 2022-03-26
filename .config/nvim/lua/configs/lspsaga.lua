local saga = require('lspsaga')

saga.init_lsp_saga({
    code_action_keys = {quit = {'q', '<ESC>'}},
    rename_action_keys = {quit = {'q', '<ESC>'}}
})
