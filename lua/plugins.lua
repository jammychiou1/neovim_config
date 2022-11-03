-- remember to run PackerCompile after modifying this file
require('packer').startup(function(use)

    -- packer manages itself
    use 'wbthomason/packer.nvim'

    -- editing, movement and text objects
    use 'machakann/vim-sandwich'            -- manipulating parentheses, brackets, quotes, etc.
    use 'vim-scripts/ReplaceWithRegister'   -- replace text object with register
    use {                                   -- new delete operation
        'svermeulen/vim-cutlass',
        config = [[require('plugins.vim-cutlass')]],
    }

    -- auto completion


    -- lsp stuff


    -- latex stuff
    use {
        'lervag/vimtex',
        ft = 'tex',
    }

    -- markdown stuff
    use {
        'iamcco/markdown-preview.nvim',
        ft = 'markdown',
        run = function() vim.fn['mkdp#util#install']() end,
    }

    -- treesitter stuff

    -- other
    use 'github/copilot.vim'
    use {                                   -- switch to English when leaving insert mode
        'lilydjwg/fcitx.vim',
        ft = 'tex',
    }
    use 'matveyt/vim-opera'                 -- range commands apply to part of line
    use {                                   -- show and remove trailing whitespaces
        'jdhao/whitespace.nvim',
        event = 'VimEnter',
    }
end)
