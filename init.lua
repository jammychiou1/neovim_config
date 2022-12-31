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
opt.showbreak = '↳'

-- smartcase for searching
opt.ignorecase = true
opt.smartcase = true

-- status line already has ruler and mode
opt.ruler = false
opt.showmode = false

-- disable netrw at the very start of your init.lua (strongly advised)
-- reference: https://github.com/nvim-tree/nvim-tree.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- synchronize the unnamed register with the clipboard register
opt.clipboard:prepend('unnamedplus')

-- -- fast spliting and tabbing
-- vim.keymap.set('n', '<leader>v', function() vim.cmd('vsplit') end)
-- vim.keymap.set('n', '<leader>s', function() vim.cmd('split') end)
-- vim.keymap.set('n', '<leader>t', function() vim.cmd('tabnew') end)

-- -- shortcut to open terminal
-- vim.keymap.set('n', '<leader>T', function() vim.cmd('terminal') end)

-- -- fast paste in insert mode
-- vim.keymap.set('i', '<M-a>', '<C-o>p', { noremap = true })

-- fast hjkl in insert mode
-- see https://neovim.io/news/2022/04#distinguishing-modifier-keys
-- and http://www.leonerd.org.uk/hacks/fixterms/
vim.keymap.set('i', '<C-h>', '<Left>', { noremap = true })
vim.keymap.set('i', '<C-j>', '<Down>', { noremap = true })
vim.keymap.set('i', '<C-k>', '<Up>', { noremap = true })
vim.keymap.set('i', '<C-l>', '<Right>', { noremap = true })

-- declare plugins and configure them
-- require('plugins')
require('lazy_plugins')

-- require('atlreg').setup()
