local utils = require('utils')

-- Setup for nvim-autopairs
utils.safe_require('nvim-autopairs', function(autopairs)
    autopairs.setup({disable_filetype = {'TelescopePrompt'}})
end)
-- End of setup for nvim-autopairs

