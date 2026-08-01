-- Kun Chen Neovim setup: oil.nvim, neogit, snacks.nvim
-- Packer bootstrap
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer()

require("packer").startup(function(use)
  use("wbthomason/packer.nvim")

  -- File system as a buffer
  use({
    "stevearc/oil.nvim",
    config = function()
      require("oil").setup({
        default_file_explorer = true,
        columns = { "icon" },
        keymaps = {
          ["<CR>"] = "actions.select",
          ["-"] = "actions.parent",
          ["_"] = "actions.open_cwd",
          ["`"] = "actions.cd",
          ["g."] = "actions.toggle_hidden",
        },
        view_options = { show_hidden = true },
      })
      vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    end,
  })

  -- Git status/diff/review
  use({
    "NeogitOrg/neogit",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      require("neogit").setup({
        integrations = { diffview = false },
        signs = {
          section = { "", "" },
          item = { "", "" },
          hunk = { "", "" },
        },
      })
      vim.keymap.set("n", "<leader>g", "<CMD>Neogit<CR>", { desc = "Open Neogit" })
    end,
  })

  -- Picker / grep / files
  use({
    "folke/snacks.nvim",
    requires = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local snacks = require("snacks")
      snacks.setup({
        picker = { enabled = true },
        explorer = { enabled = true },
        bigfile = { enabled = true },
      })
      vim.keymap.set("n", "<C-p>", function() snacks.picker.files() end, { desc = "Find files" })
      vim.keymap.set("n", "<C-f>", function() snacks.picker.grep() end, { desc = "Grep codebase" })
      vim.keymap.set("n", "<leader>e", function() snacks.explorer() end, { desc = "File explorer" })
    end,
  })

  -- Dependency already pulled by snacks; ensure explicitly
  use("nvim-tree/nvim-web-devicons")
  use("nvim-lua/plenary.nvim")

  if packer_bootstrap then
    require("packer").sync()
  end
end)

-- Core options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus"
vim.opt.cursorline = true
vim.opt.scrolloff = 8
vim.opt.undofile = true

-- Leader
vim.g.mapleader = " "

-- Quick save / quit
vim.keymap.set("n", "<leader>w", "<CMD>w<CR>")
vim.keymap.set("n", "<leader>q", "<CMD>q<CR>")

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- Colors
vim.cmd([[colorscheme default]])
