-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

--vim.cmd([[ set guicursor= ]])

vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.autoindent = false
vim.opt.smartindent = false
vim.g.autoformat = false

vim.cmd([[
  set conceallevel=0
  set concealcursor""
]])
