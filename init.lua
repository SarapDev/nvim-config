-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Set leader key (MUST be before lazy setup)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 1. Load basic options
require("core.options")

-- 2. Setup plugins
require("lazy").setup("plugins")

-- 3. Load keymaps (safely)
local status, _ = pcall(require, "core.keymaps")
if not status then
  vim.notify("Error loading keymaps", vim.log.levels.ERROR)
end
