local utils = require('utils')

-- Setup for project
utils.safe_require('project_nvim', function(project)
    project.setup{
        exclude_dirs = {'*//*'},
        detection_methods = {'pattern'},
        patterns = {'.git'}
    }
end)
-- End of setup for project

