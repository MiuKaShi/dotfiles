require('lualine').setup({
    options = {
        icons_enabled = true,
        theme = 'gruvbox_dark',
        component_separators = '|',
        section_separators = {left = ''}
    },
    sections = {
        lualine_a = {{'mode', right_padding = 2}},
        lualine_b = {'branch', 'diff', 'diagnostics', 'filename'},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {{'location', left_padding = 2}}
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
