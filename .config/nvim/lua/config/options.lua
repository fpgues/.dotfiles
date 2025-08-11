-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

--vim.cmd([[ set guicursor= ]])
-- Configura tabulação com 4 espaços
vim.opt.tabstop = 4        -- Mostra um tab como 4 espaços
vim.opt.shiftwidth = 4     -- Número de espaços usados para (auto)indentação
vim.opt.expandtab = true   -- Usa espaços em vez de tabulações reais

vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.autoindent = false
vim.opt.smartindent = false
vim.g.autoformat = false
vim.opt.termguicolors = true

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99 -- Mantém tudo expandido por padrão

vim.opt.wrap = true
vim.opt.textwidth = 80
vim.opt.autoindent = true
vim.opt.breakindent = true


vim.cmd([[
  set conceallevel=0
  set concealcursor""
]])
