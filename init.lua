-- tab settings
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- side number settings
vim.opt.number = true
vim.opt.relativenumber = true

-- cursorline
vim.opt.cursorline = true

-- wrap settings
vim.opt.breakindent = true
vim.opt.linebreak = true
vim.opt.showbreak = '> '

-- declare plugins and configure them
require('plugins')
