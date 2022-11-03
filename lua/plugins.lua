require('packer').startup(function(use)
    -- packer manages itself
    use 'wbthomason/packer.nvim'
    
    -- editing, movement and text objects
    use 'machakann/vim-sandwich'            -- manipulating parentheses, brackets, quotes, etc.
    use 'vim-scripts/ReplaceWithRegister'   -- replace text object with register
    use 'svermeulen/vim-cutlass'            -- new delete operation

    -- auto completion


    -- lsp stuff

    
    -- latex stuff
    use 'lervag/vimtex'

    -- markdown stuff
    use({
        'iamcco/markdown-preview.nvim',
        run = function() vim.fn['mkdp#util#install']() end,
    })

    -- other (copilot, fcitx, opera, vimtex)
    use 'matveyt/vim-opera'                 -- visual commands apply to part of line
    use 'github/copilot.vim'
    use 'lilydjwg/fcitx.vim'                -- switch to English when leaving insert mode

    -- treesitter stuff

end)

-- svermeulen/vim-cutlass
vim.api.nvim_set_keymap('n', 'x', 'd', {noremap = true})    -- normal mode: x{textobject} => cut textobject
vim.api.nvim_set_keymap('x', 'x', 'd', {noremap = true})    -- visual mode; x => cut selection
vim.api.nvim_set_keymap('n', 'xx', 'dd', {noremap = true})  -- normal mode: xx => cut this line
vim.api.nvim_set_keymap('n', 'X', 'D', {noremap = true})    -- normal mode: X => cut to end of line


