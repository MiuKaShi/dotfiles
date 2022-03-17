local utils = require('utils')

-- Setup for lspsaga
utils.safe_require('lspsaga', function(saga)
    saga.init_lsp_saga({
        code_action_keys = {quit = {'q', '<ESC>'}},
        rename_action_keys = {quit = {'q', '<ESC>'}}
    })
end)
-- End of setup for lspsaga

