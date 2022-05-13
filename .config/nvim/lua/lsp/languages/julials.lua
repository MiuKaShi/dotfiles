-- Installation:
--  https://discourse.julialang.org/t/neovim-languageserver-jl/37286/63?u=mroavi
--  $ julia --project=~/.julia/environments/nvim-lspconfig -e 'using Pkg; Pkg.add("LanguageServer")'
-- Instant startup with PackageCompiler:
--  https://discourse.julialang.org/t/neovim-languageserver-jl/37286/72?u=mroavi
-- Makes use of the julia bin generated using PackageCompiler to remove startup time
local M = {}

M.setup = function(on_attach, capabilities)
    require('lspconfig').julials.setup {
        on_new_config = function(new_config, _)
            local julia = vim.fn.expand '~/.julia/environments/nvim-lspconfig/bin/julia'
            if require('lspconfig').util.path.is_file(julia) then
                new_config.cmd[1] = julia
            end
        end,
        -- This just adds dirname(fname) as a fallback (see nvim-lspconfig#1768).
        root_dir = function(fname)
            local util = require 'lspconfig.util'
            return util.root_pattern 'Project.toml'(fname) or util.find_git_ancestor(fname) or util.path.dirname(fname)
        end,
        on_attach = on_attach,
        capabilities = capabilities,
    }
end

return M
