local utils = require('utils')

-- Setup for bufferline
utils.safe_require('bufferline', function(bufferline)
    bufferline.setup{
        options = {
            numbers = 'buffer_id',
            show_buffer_icons = true,
            always_show_bufferline = false
        }
    }
end)
-- End of setup for bufferline
