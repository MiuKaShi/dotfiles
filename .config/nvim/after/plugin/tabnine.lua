local utils = require('utils')

utils.safe_require('cmp_tabnine.config', function(tabnine)
    tabnine:setup{
        max_lines = 1000,
        max_num_results = 20,
        sort = true,
        run_on_every_keystroke = true,
        snippet_placeholder = '..'
    }
end)

