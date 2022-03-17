local utils = require('utils')

-- Setup for nlspsettings
utils.safe_require('nlspsettings', function(nlspsettings)
    nlspsettings.setup({
        config_home = vim.fn.stdpath('config') .. '/nlsp-settings',
        local_settings_root_markers = {'.git'},
        jsonls_append_default_schemas = true
    })
end)
-- End of setup for nlspsettings
