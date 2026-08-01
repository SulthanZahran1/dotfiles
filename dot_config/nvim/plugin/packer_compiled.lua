-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

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
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/zahranm/.cache/nvim/packer_hererocks/2.1.1774638290/share/lua/5.1/?.lua;/home/zahranm/.cache/nvim/packer_hererocks/2.1.1774638290/share/lua/5.1/?/init.lua;/home/zahranm/.cache/nvim/packer_hererocks/2.1.1774638290/lib/luarocks/rocks-5.1/?.lua;/home/zahranm/.cache/nvim/packer_hererocks/2.1.1774638290/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/zahranm/.cache/nvim/packer_hererocks/2.1.1774638290/lib/lua/5.1/?.so"
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
  neogit = {
    config = { "\27LJ\2\n³\2\0\0\6\0\21\0\0256\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\a\0005\4\6\0=\4\b\0035\4\t\0=\4\n\0035\4\v\0=\4\f\3=\3\r\2B\0\2\0016\0\14\0009\0\15\0009\0\16\0'\2\17\0'\3\18\0'\4\19\0005\5\20\0B\0\5\1K\0\1\0\1\0\1\tdesc\16Open Neogit\20<CMD>Neogit<CR>\14<leader>g\6n\bset\vkeymap\bvim\nsigns\thunk\1\3\0\0\5\5\titem\1\3\0\0\5\5\fsection\1\0\3\titem\0\fsection\0\thunk\0\1\3\0\0\5\5\17integrations\1\0\2\17integrations\0\nsigns\0\1\0\1\rdiffview\1\nsetup\vneogit\frequire\0" },
    loaded = true,
    path = "/home/zahranm/.local/share/nvim/site/pack/packer/start/neogit",
    url = "https://github.com/NeogitOrg/neogit"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/zahranm/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/nvim-tree/nvim-web-devicons"
  },
  ["oil.nvim"] = {
    config = { "\27LJ\2\nü\2\0\0\6\0\17\0\0216\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0025\3\6\0=\3\a\0025\3\b\0=\3\t\2B\0\2\0016\0\n\0009\0\v\0009\0\f\0'\2\r\0'\3\14\0'\4\15\0005\5\16\0B\0\5\1K\0\1\0\1\0\1\tdesc\26Open parent directory\17<CMD>Oil<CR>\6-\6n\bset\vkeymap\bvim\17view_options\1\0\1\16show_hidden\2\fkeymaps\1\0\5\t<CR>\19actions.select\6-\19actions.parent\6_\21actions.open_cwd\ag.\26actions.toggle_hidden\6`\15actions.cd\fcolumns\1\2\0\0\ticon\1\0\4\26default_file_explorer\2\fkeymaps\0\17view_options\0\fcolumns\0\nsetup\boil\frequire\0" },
    loaded = true,
    path = "/home/zahranm/.local/share/nvim/site/pack/packer/start/oil.nvim",
    url = "https://github.com/stevearc/oil.nvim"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/zahranm/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/zahranm/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["snacks.nvim"] = {
    config = { "\27LJ\2\n*\0\0\2\1\2\0\5-\0\0\0009\0\0\0009\0\1\0B\0\1\1K\0\1\0\0À\nfiles\vpicker)\0\0\2\1\2\0\5-\0\0\0009\0\0\0009\0\1\0B\0\1\1K\0\1\0\0À\tgrep\vpicker\"\0\0\2\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\0À\rexplorer÷\2\1\0\a\0\23\0&6\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\4\0005\4\3\0=\4\5\0035\4\6\0=\4\a\0035\4\b\0=\4\t\3B\1\2\0016\1\n\0009\1\v\0019\1\f\1'\3\r\0'\4\14\0003\5\15\0005\6\16\0B\1\5\0016\1\n\0009\1\v\0019\1\f\1'\3\r\0'\4\17\0003\5\18\0005\6\19\0B\1\5\0016\1\n\0009\1\v\0019\1\f\1'\3\r\0'\4\20\0003\5\21\0005\6\22\0B\1\5\0012\0\0€K\0\1\0\1\0\1\tdesc\18File explorer\0\14<leader>e\1\0\1\tdesc\18Grep codebase\0\n<C-f>\1\0\1\tdesc\15Find files\0\n<C-p>\6n\bset\vkeymap\bvim\fbigfile\1\0\1\fenabled\2\rexplorer\1\0\1\fenabled\2\vpicker\1\0\3\vpicker\0\fbigfile\0\rexplorer\0\1\0\1\fenabled\2\nsetup\vsnacks\frequire\0" },
    loaded = true,
    path = "/home/zahranm/.local/share/nvim/site/pack/packer/start/snacks.nvim",
    url = "https://github.com/folke/snacks.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: oil.nvim
time([[Config for oil.nvim]], true)
try_loadstring("\27LJ\2\nü\2\0\0\6\0\17\0\0216\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0025\3\6\0=\3\a\0025\3\b\0=\3\t\2B\0\2\0016\0\n\0009\0\v\0009\0\f\0'\2\r\0'\3\14\0'\4\15\0005\5\16\0B\0\5\1K\0\1\0\1\0\1\tdesc\26Open parent directory\17<CMD>Oil<CR>\6-\6n\bset\vkeymap\bvim\17view_options\1\0\1\16show_hidden\2\fkeymaps\1\0\5\t<CR>\19actions.select\6-\19actions.parent\6_\21actions.open_cwd\ag.\26actions.toggle_hidden\6`\15actions.cd\fcolumns\1\2\0\0\ticon\1\0\4\26default_file_explorer\2\fkeymaps\0\17view_options\0\fcolumns\0\nsetup\boil\frequire\0", "config", "oil.nvim")
time([[Config for oil.nvim]], false)
-- Config for: neogit
time([[Config for neogit]], true)
try_loadstring("\27LJ\2\n³\2\0\0\6\0\21\0\0256\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\a\0005\4\6\0=\4\b\0035\4\t\0=\4\n\0035\4\v\0=\4\f\3=\3\r\2B\0\2\0016\0\14\0009\0\15\0009\0\16\0'\2\17\0'\3\18\0'\4\19\0005\5\20\0B\0\5\1K\0\1\0\1\0\1\tdesc\16Open Neogit\20<CMD>Neogit<CR>\14<leader>g\6n\bset\vkeymap\bvim\nsigns\thunk\1\3\0\0\5\5\titem\1\3\0\0\5\5\fsection\1\0\3\titem\0\fsection\0\thunk\0\1\3\0\0\5\5\17integrations\1\0\2\17integrations\0\nsigns\0\1\0\1\rdiffview\1\nsetup\vneogit\frequire\0", "config", "neogit")
time([[Config for neogit]], false)
-- Config for: snacks.nvim
time([[Config for snacks.nvim]], true)
try_loadstring("\27LJ\2\n*\0\0\2\1\2\0\5-\0\0\0009\0\0\0009\0\1\0B\0\1\1K\0\1\0\0À\nfiles\vpicker)\0\0\2\1\2\0\5-\0\0\0009\0\0\0009\0\1\0B\0\1\1K\0\1\0\0À\tgrep\vpicker\"\0\0\2\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\0À\rexplorer÷\2\1\0\a\0\23\0&6\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\4\0005\4\3\0=\4\5\0035\4\6\0=\4\a\0035\4\b\0=\4\t\3B\1\2\0016\1\n\0009\1\v\0019\1\f\1'\3\r\0'\4\14\0003\5\15\0005\6\16\0B\1\5\0016\1\n\0009\1\v\0019\1\f\1'\3\r\0'\4\17\0003\5\18\0005\6\19\0B\1\5\0016\1\n\0009\1\v\0019\1\f\1'\3\r\0'\4\20\0003\5\21\0005\6\22\0B\1\5\0012\0\0€K\0\1\0\1\0\1\tdesc\18File explorer\0\14<leader>e\1\0\1\tdesc\18Grep codebase\0\n<C-f>\1\0\1\tdesc\15Find files\0\n<C-p>\6n\bset\vkeymap\bvim\fbigfile\1\0\1\fenabled\2\rexplorer\1\0\1\fenabled\2\vpicker\1\0\3\vpicker\0\fbigfile\0\rexplorer\0\1\0\1\fenabled\2\nsetup\vsnacks\frequire\0", "config", "snacks.nvim")
time([[Config for snacks.nvim]], false)

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
