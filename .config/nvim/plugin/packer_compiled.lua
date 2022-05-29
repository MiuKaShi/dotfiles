-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/miuka/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/miuka/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/miuka/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/miuka/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/miuka/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["Comment.nvim"] = {
    config = { "require('configs.comment')" },
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  LuaSnip = {
    config = { "require('configs.luasnip')" },
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["asyncrun.vim"] = {
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/asyncrun.vim",
    url = "https://github.com/skywind3000/asyncrun.vim"
  },
  ["bibtexcite.vim"] = {
    config = { "require('configs.bibtexcite')" },
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/bibtexcite.vim",
    url = "https://github.com/ferdinandyb/bibtexcite.vim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-cmdline"] = {
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/cmp-cmdline",
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-matlab"] = {
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/cmp-matlab",
    url = "https://github.com/mstanciu552/cmp-matlab"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-nvim-lua"] = {
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/cmp-nvim-lua",
    url = "https://github.com/hrsh7th/cmp-nvim-lua"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  ["cmp-rg"] = {
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/cmp-rg",
    url = "https://github.com/lukas-reineke/cmp-rg"
  },
  ["cmp-tabnine"] = {
    config = { "require('configs.tabnine')" },
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/cmp-tabnine",
    url = "https://github.com/tzachar/cmp-tabnine"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["copilot.vim"] = {
    config = { "require('configs.copilot')" },
    loaded = false,
    needs_bufread = false,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/opt/copilot.vim",
    url = "https://github.com/github/copilot.vim"
  },
  ["fcitx.nvim"] = {
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/fcitx.nvim",
    url = "https://github.com/h-hg/fcitx.nvim"
  },
  ["fm-nvim"] = {
    config = { "require('configs.fm')" },
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/fm-nvim",
    url = "https://github.com/is0n/fm-nvim"
  },
  fzf = {
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/fzf",
    url = "https://github.com/junegunn/fzf"
  },
  ["fzf-wordnet.vim"] = {
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/fzf-wordnet.vim",
    url = "https://github.com/Avi-D-coder/fzf-wordnet.vim"
  },
  ["fzf.vim"] = {
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/fzf.vim",
    url = "https://github.com/junegunn/fzf.vim"
  },
  ["goyo.vim"] = {
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/goyo.vim",
    url = "https://github.com/junegunn/goyo.vim"
  },
  ["gruvbox.nvim"] = {
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/gruvbox.nvim",
    url = "https://github.com/ellisonleao/gruvbox.nvim"
  },
  ["impatient.nvim"] = {
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/impatient.nvim",
    url = "https://github.com/lewis6991/impatient.nvim"
  },
  ["indent-blankline.nvim"] = {
    config = { "require('configs.indentline')" },
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/indent-blankline.nvim",
    url = "https://github.com/lukas-reineke/indent-blankline.nvim"
  },
  ["julia-vim"] = {
    config = { "require('configs.julia')" },
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/julia-vim",
    url = "https://github.com/JuliaEditorSupport/julia-vim"
  },
  ["leap.nvim"] = {
    config = { "require('leap').set_default_keymaps()" },
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/leap.nvim",
    url = "https://github.com/ggandor/leap.nvim"
  },
  ["limelight.vim"] = {
    config = { "require('configs.limelight')" },
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/limelight.vim",
    url = "https://github.com/junegunn/limelight.vim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/lspkind-nvim",
    url = "https://github.com/onsails/lspkind-nvim"
  },
  ["lspsaga.nvim"] = {
    config = { "require('configs.lspsaga')" },
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/lspsaga.nvim",
    url = "https://github.com/tami5/lspsaga.nvim"
  },
  ["lua-dev.nvim"] = {
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/lua-dev.nvim",
    url = "https://github.com/folke/lua-dev.nvim"
  },
  ["lualine.nvim"] = {
    config = { "require('configs.lualine')" },
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["markdown-preview.nvim"] = {
    config = { "require('configs.mkdp')" },
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/markdown-preview.nvim",
    url = "https://github.com/iamcco/markdown-preview.nvim"
  },
  neoformat = {
    config = { "require('configs.neoformat')" },
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/neoformat",
    url = "https://github.com/sbdchd/neoformat"
  },
  neorg = {
    config = { "require('configs.neorg')" },
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/neorg",
    url = "https://github.com/nvim-neorg/neorg"
  },
  ["neorg-telescope"] = {
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/neorg-telescope",
    url = "https://github.com/nvim-neorg/neorg-telescope"
  },
  ["nvim-autopairs"] = {
    config = { "require('configs.autopairs')" },
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-cmp"] = {
    config = { "require('configs.cmp')" },
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-colorizer.lua"] = {
    config = { "require('configs.colorizer')" },
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua",
    url = "https://github.com/norcalli/nvim-colorizer.lua"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-surround"] = {
    config = { "require('configs.surround')" },
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/nvim-surround",
    url = "https://github.com/kylechui/nvim-surround"
  },
  ["nvim-treesitter"] = {
    config = { "require('configs.treesitter')" },
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  playground = {
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/playground",
    url = "https://github.com/nvim-treesitter/playground"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  rainbow = {
    config = { "require('configs.rainbow')" },
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/rainbow",
    url = "https://github.com/luochen1990/rainbow"
  },
  ["stylua-nvim"] = {
    config = { "require('configs.stylua')" },
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/stylua-nvim",
    url = "https://github.com/ckipp01/stylua-nvim"
  },
  ["targets.vim"] = {
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/targets.vim",
    url = "https://github.com/wellle/targets.vim"
  },
  ["telescope-file-browser.nvim"] = {
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/telescope-file-browser.nvim",
    url = "https://github.com/nvim-telescope/telescope-file-browser.nvim"
  },
  ["telescope-ui-select.nvim"] = {
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/telescope-ui-select.nvim",
    url = "https://github.com/nvim-telescope/telescope-ui-select.nvim"
  },
  ["telescope.nvim"] = {
    config = { "require('configs.telescope')" },
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["vim-cython-syntax"] = {
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/vim-cython-syntax",
    url = "https://github.com/lambdalisue/vim-cython-syntax"
  },
  ["vim-easy-align"] = {
    config = { "require('configs.easyalign')" },
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/vim-easy-align",
    url = "https://github.com/junegunn/vim-easy-align"
  },
  ["vim-gf-list"] = {
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/vim-gf-list",
    url = "https://github.com/numEricL/vim-gf-list"
  },
  ["vim-gtfo"] = {
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/vim-gtfo",
    url = "https://github.com/justinmk/vim-gtfo"
  },
  ["vim-illuminate"] = {
    config = { "require('configs.illuminate')" },
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/vim-illuminate",
    url = "https://github.com/RRethy/vim-illuminate"
  },
  ["vim-pandoc-syntax"] = {
    config = { "\27LJ\2\nô\1\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0Ô\1        augroup pandoc_syntax\n        autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown\n        autocmd BufNewFile,BufFilePre,BufRead *.md set syntax=markdown.pandoc\n        augroup END\n      \bcmd\bvim\0" },
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/vim-pandoc-syntax",
    url = "https://github.com/vim-pandoc/vim-pandoc-syntax"
  },
  ["vim-tridactyl"] = {
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/vim-tridactyl",
    url = "https://github.com/tridactyl/vim-tridactyl"
  },
  ["vim-wakatime"] = {
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/vim-wakatime",
    url = "https://github.com/wakatime/vim-wakatime"
  },
  ["which-key.nvim"] = {
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/which-key.nvim",
    url = "https://github.com/folke/which-key.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: vim-easy-align
time([[Config for vim-easy-align]], true)
require('configs.easyalign')
time([[Config for vim-easy-align]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
require('configs.treesitter')
time([[Config for nvim-treesitter]], false)
-- Config for: vim-pandoc-syntax
time([[Config for vim-pandoc-syntax]], true)
try_loadstring("\27LJ\2\nô\1\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0Ô\1        augroup pandoc_syntax\n        autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown\n        autocmd BufNewFile,BufFilePre,BufRead *.md set syntax=markdown.pandoc\n        augroup END\n      \bcmd\bvim\0", "config", "vim-pandoc-syntax")
time([[Config for vim-pandoc-syntax]], false)
-- Config for: lualine.nvim
time([[Config for lualine.nvim]], true)
require('configs.lualine')
time([[Config for lualine.nvim]], false)
-- Config for: markdown-preview.nvim
time([[Config for markdown-preview.nvim]], true)
require('configs.mkdp')
time([[Config for markdown-preview.nvim]], false)
-- Config for: neoformat
time([[Config for neoformat]], true)
require('configs.neoformat')
time([[Config for neoformat]], false)
-- Config for: rainbow
time([[Config for rainbow]], true)
require('configs.rainbow')
time([[Config for rainbow]], false)
-- Config for: Comment.nvim
time([[Config for Comment.nvim]], true)
require('configs.comment')
time([[Config for Comment.nvim]], false)
-- Config for: cmp-tabnine
time([[Config for cmp-tabnine]], true)
require('configs.tabnine')
time([[Config for cmp-tabnine]], false)
-- Config for: indent-blankline.nvim
time([[Config for indent-blankline.nvim]], true)
require('configs.indentline')
time([[Config for indent-blankline.nvim]], false)
-- Config for: vim-illuminate
time([[Config for vim-illuminate]], true)
require('configs.illuminate')
time([[Config for vim-illuminate]], false)
-- Config for: nvim-autopairs
time([[Config for nvim-autopairs]], true)
require('configs.autopairs')
time([[Config for nvim-autopairs]], false)
-- Config for: julia-vim
time([[Config for julia-vim]], true)
require('configs.julia')
time([[Config for julia-vim]], false)
-- Config for: stylua-nvim
time([[Config for stylua-nvim]], true)
require('configs.stylua')
time([[Config for stylua-nvim]], false)
-- Config for: nvim-cmp
time([[Config for nvim-cmp]], true)
require('configs.cmp')
time([[Config for nvim-cmp]], false)
-- Config for: bibtexcite.vim
time([[Config for bibtexcite.vim]], true)
require('configs.bibtexcite')
time([[Config for bibtexcite.vim]], false)
-- Config for: leap.nvim
time([[Config for leap.nvim]], true)
require('leap').set_default_keymaps()
time([[Config for leap.nvim]], false)
-- Config for: nvim-colorizer.lua
time([[Config for nvim-colorizer.lua]], true)
require('configs.colorizer')
time([[Config for nvim-colorizer.lua]], false)
-- Config for: limelight.vim
time([[Config for limelight.vim]], true)
require('configs.limelight')
time([[Config for limelight.vim]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
require('configs.telescope')
time([[Config for telescope.nvim]], false)
-- Config for: fm-nvim
time([[Config for fm-nvim]], true)
require('configs.fm')
time([[Config for fm-nvim]], false)
-- Config for: LuaSnip
time([[Config for LuaSnip]], true)
require('configs.luasnip')
time([[Config for LuaSnip]], false)
-- Config for: neorg
time([[Config for neorg]], true)
require('configs.neorg')
time([[Config for neorg]], false)
-- Config for: nvim-surround
time([[Config for nvim-surround]], true)
require('configs.surround')
time([[Config for nvim-surround]], false)
-- Config for: lspsaga.nvim
time([[Config for lspsaga.nvim]], true)
require('configs.lspsaga')
time([[Config for lspsaga.nvim]], false)
if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
