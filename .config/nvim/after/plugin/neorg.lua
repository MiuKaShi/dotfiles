local utils = require('utils')

utils.safe_require('neorg', function(neorg)
    neorg.setup{
        load = {
            ['core.defaults'] = {},
            ['core.norg.dirman'] = {
                config = {
                    autochdir = true,
                    workspaces = {work = '~/notes/work', home = '~/notes/home'}
                }
            },
            ['core.norg.qol.toc'] = {},
            ['core.norg.concealer'] = {}
        }
    }
end)

