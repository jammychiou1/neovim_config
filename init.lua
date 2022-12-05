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

-- smartcase for searching
opt.ignorecase = true
opt.smartcase = true

-- status line already has ruler
opt.ruler = false

-- reference:
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- synchronize the unnamed register with the clipboard register
opt.clipboard:prepend('unnamedplus')

vim.keymap.set('n', '<leader>T', function() vim.cmd('terminal') end)
vim.keymap.set('n', '<leader>v', function() vim.cmd('vsplit') end)
vim.keymap.set('n', '<leader>s', function() vim.cmd('split') end)
vim.keymap.set('n', '<leader>t', function() vim.cmd('tabnew') end)

-- declare plugins and configure them
require('plugins')
