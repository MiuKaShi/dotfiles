local gps = require('nvim-gps')

require('lualine').setup({
    options = {
        icons_enabled = true,
        theme = 'pywal-nvim',
        component_separators = '|',
        section_separators = {left = '', right = ''}
    },
    sections = {
        lualine_a = {{'mode', separator = {left = ''}, right_padding = 2}},
        lualine_b = {'branch', 'diff', 'diagnostics', 'filename'},
        lualine_c = {{gps.get_location, cond = gps.is_available}},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {
            {'location', separator = {right = ''}, left_padding = 2}
        }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    extensions = {}
})
