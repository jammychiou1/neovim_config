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

    -- copilot
    use {
        'github/copilot.vim',
        config = function()
            require('plugins.copilot')
        end,
    }

    -- file finding
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        requires = { {'nvim-lua/plenary.nvim'} }
        -- remember to install ripgrep
    }

    -- auto completion
    use {
        'hrsh7th/nvim-cmp',
        config = function()
            require('plugins.nvim-cmp')
        end,
        after = 'copilot.vim',
    }
    use { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' }
    use { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' }
    use { 'hrsh7th/cmp-path', after = 'nvim-cmp' }

    -- lsp stuff
    use {                                       -- auto install lsp & other servers
        'williamboman/mason.nvim',
        config = function()
            require('mason').setup()
        end,
    }
    use {
        'williamboman/mason-lspconfig.nvim',    -- auto config lsp servers
        config = function()
            require('plugins.mason-lspconfig')
        end,
        after = {
            'mason.nvim',
            'nvim-lspconfig',
        },
    }
    use {
        'neovim/nvim-lspconfig',
        config = function()
            require('plugins.nvim-lspconfig')
        end,
        after = 'cmp-nvim-lsp',
    }

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

    -- fancy visuals
    use 'kyazdani42/nvim-web-devicons'      -- icons
    use {                                   -- colorscheme
        'catppuccin/nvim',
        as = 'catppuccin',
        config = function()
            require('catppuccin').setup {
                flavour = 'macchiato',
                integrations = {
                    semantic_tokens = true,
                },
            }
            vim.api.nvim_command 'colorscheme catppuccin'
        end
    }
    use {                                   -- fancy statusline, remember to install patch fonts https://www.nerdfonts.com/#home
        'nvim-lualine/lualine.nvim',
        config = function()
            require('lualine').setup({
                options = {
                    theme = 'catppuccin',
                },
            })
        end,
    }
    use {                                   -- fancy buffer line
        'akinsho/bufferline.nvim',
        tag = 'v3.*',
        config = function()
            require('bufferline').setup({
                options = {
                    mode = 'tabs',
                },
                highlights = require('catppuccin.groups.integrations.bufferline').get(),
            })
        end,
    }
    use {
        'nvim-tree/nvim-tree.lua',
        config = function()
            require('nvim-tree').setup({
                open_on_setup = true,
                open_on_setup_file = true,
                open_on_tab = true,
            })
        end,
    }
    use {                                   -- cfg syntax parsing
        'nvim-treesitter/nvim-treesitter',
        run = function()
            require('nvim-treesitter.install').update({ with_sync = true })
        end,
        config = function()
            require'nvim-treesitter.configs'.setup {
                highlight = {
                    enable = false
                },
            }
        end,
    }
    use {
      'nvim-treesitter/nvim-treesitter-textobjects'
    }
    use {
        'theHamsta/nvim-semantic-tokens',   -- semantic highlighting
        after = 'nvim-treesitter',
        config = function()
            require('nvim-semantic-tokens').setup {
                preset = 'default',
                -- highlighters is a list of modules following the interface of nvim-semantic-tokens.table-highlighter or
                -- function with the signature: highlight_token(ctx, token, highlight) where
                --        ctx (as defined in :h lsp-handler)
                --        token  (as defined in :h vim.lsp.semantic_tokens.on_full())
                --        highlight (a helper function that you can call (also multiple times) with the determined highlight group(s) as the only parameter)
                highlighters = { require 'nvim-semantic-tokens.table-highlighter'}
            }
        end,
    }

    -- other
    use {                                   -- switch to English when leaving insert mode
        'lilydjwg/fcitx.vim',
        setup = function()
            vim.g.fcitx5_remote = 'fcitx5-remote'
        end,
        ft = { 'tex', 'markdown' },
    }
    use 'matveyt/vim-opera'                 -- range commands apply to part of line
    use {                                   -- show and remove trailing whitespaces
        'jdhao/whitespace.nvim',
        event = 'VimEnter',
    }
end)
