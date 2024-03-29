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

-- wrap settings
opt.breakindent = true
opt.linebreak = true
opt.showbreak = '↳'

-- smartcase for searching
opt.ignorecase = true
opt.smartcase = true

-- status line already has ruler and mode
opt.ruler = false
opt.showmode = false

-- split right and below
opt.splitright = true
opt.splitbelow = true

-- synchronize the unnamed register with the clipboard register
opt.clipboard:prepend('unnamedplus')

-- set default shell of built-in terminal
opt.shell = 'fish'
