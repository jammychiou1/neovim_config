-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--single-branch",
        "https://github.com/folke/lazy.nvim.git",
        lazypath,
    })
end
vim.opt.runtimepath:prepend(lazypath)

-- declare plugins and configure them
-- require('plugins')
-- require('lazy_plugins')
require("lazy").setup("plugins")

-- require('atlreg').setup()

local opt = vim.opt

-- tab settings
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

-- font settings for neovide
opt.guifont = 'VictorMono Nerd Font:h10'

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

-- split right and below
opt.splitright = true
opt.splitbelow = true

-- synchronize the unnamed register with the clipboard register
opt.clipboard:prepend('unnamedplus')

-- fast new tab
vim.keymap.set('n', '<C-w>t', function() vim.cmd('tabnew') end, { desc = 'Open new tab' })

-- fast paste in insert mode
vim.keymap.set('i', '<M-a>', '<C-r>+', { noremap = true, desc = 'Fast paste' })

-- fast home and end
vim.keymap.set('n', 'H', '_', { noremap = true, desc = 'Start of line' })
vim.keymap.set('n', 'L', '$', { noremap = true, desc = 'End of line' })

-- fast hjkl in insert mode
-- see https://neovim.io/news/2022/04#distinguishing-modifier-keys
-- and http://www.leonerd.org.uk/hacks/fixterms/
vim.keymap.set('i', '<C-h>', '<Left>', { noremap = true, desc = 'Left' })
vim.keymap.set('i', '<C-j>', '<Down>', { noremap = true, desc = 'Down' })
vim.keymap.set('i', '<C-k>', '<Up>', { noremap = true, desc = 'Up' })
vim.keymap.set('i', '<C-l>', '<Right>', { noremap = true, desc = 'Right' })

