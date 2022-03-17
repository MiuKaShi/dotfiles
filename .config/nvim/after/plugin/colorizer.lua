local utils = require('utils')

-- [start] 颜色配置
utils.safe_require('colorizer', function(color)
    color.setup()
end)
-- [end] 颜色配置
