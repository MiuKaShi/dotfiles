require('neorg').setup{
    load = {
        ['core.defaults'] = {},
        ['core.integrations.telescope'] = {},
        ['core.keybinds'] = {
            config = {
                neorg_leader = ',',
                hook = function(keybinds)
                    keybinds.unmap('norg', 'i', '<C-l>')
                end
            }
        },
        ['core.norg.concealer'] = {},
        ['core.norg.completion'] = {config = {engine = 'nvim-cmp'}},
        ['core.norg.dirman'] = {
            config = {
                workspaces = {notes = '~/neorg/notes', tasks = '~/neorg/tasks'},
                autodetect = true,
                autochdir = true
            }
        },
        ['core.gtd.base'] = {config = {workspace = 'tasks'}},
        ['core.norg.qol.toc'] = {}
    }
}
