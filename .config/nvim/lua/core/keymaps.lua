vim.g.mapleader = ' '
vim.g.maploacalleader = ' '

vim.opt.backspace = '2'
vim.opt.showcmd = true
vim.opt.laststatus = 2
vim.opt.autowrite = true
vim.opt.cursorline = true
vim.opt.autoread = true

-- use spaces for tabs
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.shiftround = true
vim.opt.expandtab = true

-- set cursor back to fat
vim.opt.guicursor = ''

vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')
