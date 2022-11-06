local opt = vim.opt

-- tab settings
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

-- side number settings
opt.number = true
opt.relativenumber = true

-- cursorline
opt.cursorline = true
-- opt.cursorcolumn = true

-- wrap settings
opt.breakindent = true
opt.linebreak = true
opt.showbreak = '> '

-- status line already has ruler
opt.ruler = false

-- reference:
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- declare plugins and configure them
require('plugins')
