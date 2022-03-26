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
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/bibtexcite.vim",
    url = "https://github.com/ferdinandyb/bibtexcite.vim"
  },
  ["bufferline.nvim"] = {
    config = { "require('configs.bufferline')" },
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/bufferline.nvim",
    url = "https://github.com/akinsho/bufferline.nvim"
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
  ["editorconfig-vim"] = {
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/editorconfig-vim",
    url = "https://github.com/editorconfig/editorconfig-vim"
  },
  ["fcitx.nvim"] = {
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/fcitx.nvim",
    url = "https://github.com/h-hg/fcitx.nvim"
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
  ["fzf.devicon.vim"] = {
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/fzf.devicon.vim",
    url = "https://github.com/coreyja/fzf.devicon.vim"
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
  gruvbox = {
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/gruvbox",
    url = "https://github.com/morhetz/gruvbox"
  },
  ["impatient.nvim"] = {
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/impatient.nvim",
    url = "https://github.com/lewis6991/impatient.nvim"
  },
  indentLine = {
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/indentLine",
    url = "https://github.com/Yggdroot/indentLine"
  },
  ["limelight.vim"] = {
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
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/markdown-preview.nvim",
    url = "https://github.com/iamcco/markdown-preview.nvim"
  },
  neoformat = {
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
  ["nlsp-settings.nvim"] = {
    config = { "require('configs.nlspset')" },
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/nlsp-settings.nvim",
    url = "https://github.com/tamago324/nlsp-settings.nvim"
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
  ["nvim-lsp-installer"] = {
    config = { "require('configs.lspinstaller')" },
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/nvim-lsp-installer",
    url = "https://github.com/williamboman/nvim-lsp-installer"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-tree.lua"] = {
    config = { "require('configs.tree')" },
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/nvim-tree.lua",
    url = "https://github.com/kyazdani42/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    config = { "require('configs.treesitter')" },
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-ts-context-commentstring"] = {
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/nvim-ts-context-commentstring",
    url = "https://github.com/JoosepAlviste/nvim-ts-context-commentstring"
  },
  ["nvim-ts-rainbow"] = {
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/nvim-ts-rainbow",
    url = "https://github.com/p00f/nvim-ts-rainbow"
  },
  ["nvim-web-devicons"] = {
    config = { "require('configs.webdevicons')" },
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
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
  ["project.nvim"] = {
    config = { "require('configs.project')" },
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/project.nvim",
    url = "https://github.com/ahmedkhalf/project.nvim"
  },
  pywal = {
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/pywal",
    url = "https://github.com/AlphaTechnolog/pywal.nvim"
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
  ["vim-commentary"] = {
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/vim-commentary",
    url = "https://github.com/tpope/vim-commentary"
  },
  ["vim-devicons"] = {
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/vim-devicons",
    url = "https://github.com/ryanoasis/vim-devicons"
  },
  ["vim-easymotion"] = {
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/vim-easymotion",
    url = "https://github.com/easymotion/vim-easymotion"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
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
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/vim-illuminate",
    url = "https://github.com/RRethy/vim-illuminate"
  },
  ["vim-markdown"] = {
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/vim-markdown",
    url = "https://github.com/preservim/vim-markdown"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/vim-surround",
    url = "https://github.com/tpope/vim-surround"
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
  vimwiki = {
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/vimwiki",
    url = "https://github.com/vimwiki/vimwiki"
  },
  ["which-key.nvim"] = {
    loaded = true,
    path = "/home/miuka/.local/share/nvim/site/pack/packer/start/which-key.nvim",
    url = "https://github.com/folke/which-key.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: nvim-web-devicons
time([[Config for nvim-web-devicons]], true)
require('configs.webdevicons')
time([[Config for nvim-web-devicons]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
require('configs.treesitter')
time([[Config for nvim-treesitter]], false)
-- Config for: neorg
time([[Config for neorg]], true)
require('configs.neorg')
time([[Config for neorg]], false)
-- Config for: nlsp-settings.nvim
time([[Config for nlsp-settings.nvim]], true)
require('configs.nlspset')
time([[Config for nlsp-settings.nvim]], false)
-- Config for: nvim-cmp
time([[Config for nvim-cmp]], true)
require('configs.cmp')
time([[Config for nvim-cmp]], false)
-- Config for: nvim-autopairs
time([[Config for nvim-autopairs]], true)
require('configs.autopairs')
time([[Config for nvim-autopairs]], false)
-- Config for: lspsaga.nvim
time([[Config for lspsaga.nvim]], true)
require('configs.lspsaga')
time([[Config for lspsaga.nvim]], false)
-- Config for: LuaSnip
time([[Config for LuaSnip]], true)
require('configs.luasnip')
time([[Config for LuaSnip]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
require('configs.telescope')
time([[Config for telescope.nvim]], false)
-- Config for: nvim-colorizer.lua
time([[Config for nvim-colorizer.lua]], true)
require('configs.colorizer')
time([[Config for nvim-colorizer.lua]], false)
-- Config for: lualine.nvim
time([[Config for lualine.nvim]], true)
require('configs.lualine')
time([[Config for lualine.nvim]], false)
-- Config for: nvim-lsp-installer
time([[Config for nvim-lsp-installer]], true)
require('configs.lspinstaller')
time([[Config for nvim-lsp-installer]], false)
-- Config for: bufferline.nvim
time([[Config for bufferline.nvim]], true)
require('configs.bufferline')
time([[Config for bufferline.nvim]], false)
-- Config for: cmp-tabnine
time([[Config for cmp-tabnine]], true)
require('configs.tabnine')
time([[Config for cmp-tabnine]], false)
-- Config for: project.nvim
time([[Config for project.nvim]], true)
require('configs.project')
time([[Config for project.nvim]], false)
-- Config for: nvim-tree.lua
time([[Config for nvim-tree.lua]], true)
require('configs.tree')
time([[Config for nvim-tree.lua]], false)
if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
