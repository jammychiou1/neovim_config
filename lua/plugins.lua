-- remember to run PackerCompile after modifying this file
require('packer').startup(function(use)

    -- packer manages itself
    use 'wbthomason/packer.nvim'

    -- editing, movement and text objects
    use 'machakann/vim-sandwich'            -- manipulating parentheses, brackets, quotes, etc.
    use 'vim-scripts/ReplaceWithRegister'   -- replace text object with register
    use {                                   -- new delete operation
        'svermeulen/vim-cutlass',
        config = function()
            require('plugins.vim-cutlass')
        end,
    }
    use 'vim-scripts/argtextobj.vim'        -- text objects for arguments
    use {                                   -- easy motion
        'phaazon/hop.nvim',
        branch = 'v2',                      -- optional but strongly recommended
        config = function()
            require('plugins.hop')
        end
    }

    -- auto completion
    use {
        'hrsh7th/nvim-cmp',
        config = function()
            require('plugins.nvim-cmp')
        end,
    }
    use { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' }
    use { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' }
    use { 'hrsh7th/cmp-path', after = 'nvim-cmp' }

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
        run = function()
            vim.fn['mkdp#util#install']()
        end,
    }

    -- treesitter stuff

    -- other
    use {
        'github/copilot.vim',
        config = function()
            require('plugins.copilot')
        end,
    }
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
