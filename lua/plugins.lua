-- remember to run PackerCompile after modifying this file

require('packer').startup(function(use)

    -- packer manages itself
    use 'wbthomason/packer.nvim'

    -- editing, movement and text objects
    use 'machakann/vim-sandwich' -- manipulating parentheses, brackets, quotes, etc.
    use 'vim-scripts/ReplaceWithRegister' -- replace text object with register
    use { -- new delete operation
        'svermeulen/vim-cutlass',
        config = function()
            require('plugins.vim-cutlass')
            vim.api.nvim_command 'runtime macros/sandwich/keymap/surround.vim'
        end,
    }
    use 'vim-scripts/argtextobj.vim' -- text objects for arguments
    use { -- easy motion
        'phaazon/hop.nvim',
        branch = 'v2', -- optional but strongly recommended
        config = function()
            require('plugins.hop')
        end
    }
    use { -- fast insert mode exit
        'max397574/better-escape.nvim',
        config = function()
            require('better_escape').setup({
                keys = function()
                    return vim.api.nvim_win_get_cursor(0)[2] > 1 and '<esc>l' or '<esc>'
                end,
            })

            -- also exit terminal mode using <C-j><C-j>
            vim.api.nvim_set_keymap('t', '<C-j><C-j>', '<C-\\><C-n>', { noremap = true })
        end,
    }

    -- copilot
    -- use {
    --     'github/copilot.vim',
    --     config = function()
    --         require('plugins.copilot')
    --     end,
    -- }

    -- file finding
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        requires = { { 'nvim-lua/plenary.nvim' } }
        -- remember to install ripgrep
    }

    -- snippets
    use 'hrsh7th/vim-vsnip' -- snippet engine
    use 'rafamadriz/friendly-snippets' -- useful snippets

    -- auto completion
    use { -- completion engine
        'hrsh7th/nvim-cmp',
        config = function()
            require('plugins.nvim-cmp')
        end,
        after = {
            -- 'copilot.vim',
            'vim-vsnip',
        },
    }
    -- completion sources
    use { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' }
    use { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' }
    use { 'hrsh7th/cmp-path', after = 'nvim-cmp' }
    use { 'hrsh7th/cmp-vsnip', after = 'nvim-cmp' }

    -- lsp stuff
    use { -- auto install lsp & other servers
        'williamboman/mason.nvim',
        config = function()
            require('mason').setup()
        end,
    }
    use { -- auto config lsp servers
        'williamboman/mason-lspconfig.nvim',
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
        config = function()
            -- vim.opt.conceallevel = 2
        end,
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
    use 'kyazdani42/nvim-web-devicons' -- icons
    use { -- colorscheme
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
    use { -- fancy statusline, remember to install patch fonts https://www.nerdfonts.com/#home
        'nvim-lualine/lualine.nvim',
        config = function()
            require('lualine').setup({
                options = {
                    theme = 'catppuccin',
                },
            })
        end,
    }
    use { -- fancy buffer line
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
    use { -- directory viewer
        'nvim-tree/nvim-tree.lua',
        config = function()
            require('nvim-tree').setup({
                open_on_setup = true,
                open_on_setup_file = true,
                open_on_tab = true,
            })
        end,
    }
    use { -- cfg syntax parsing
        'nvim-treesitter/nvim-treesitter',
        run = function()
            require('nvim-treesitter.install').update({ with_sync = true })
        end,
        config = function()
            require 'nvim-treesitter.configs'.setup {
                highlight = {
                    enable = false
                },
            }

            local opt = vim.opt

            opt.foldmethod = 'expr'
            opt.foldexpr = 'nvim_treesitter#foldexpr()'
        end,
    }
    use {
        'nvim-treesitter/nvim-treesitter-textobjects'
    }
    use { -- semantic highlighting
        'theHamsta/nvim-semantic-tokens',
        after = 'nvim-treesitter',
        config = function()
            require('nvim-semantic-tokens').setup {
                preset = 'default',
                -- highlighters is a list of modules following the interface of nvim-semantic-tokens.table-highlighter or
                -- function with the signature: highlight_token(ctx, token, highlight) where
                --        ctx (as defined in :h lsp-handler)
                --        token  (as defined in :h vim.lsp.semantic_tokens.on_full())
                --        highlight (a helper function that you can call (also multiple times) with the determined highlight group(s) as the only parameter)
                highlighters = { require 'nvim-semantic-tokens.table-highlighter' }
            }
        end,
    }

    -- modern folding
    use {
        'kevinhwang91/nvim-ufo',
        requires = 'kevinhwang91/promise-async',
        config = function()
            vim.o.foldcolumn = '1' -- '0' is not bad
            vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
            vim.o.foldlevelstart = 99
            vim.o.foldenable = true

            -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
            vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
            vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

            require('ufo').setup()
            -- require('ufo').setup {
            --     provider_selector = function(bufnr, filetype)
            --         return {
            --             -- 'lsp',
            --             'treesitter',
            --             'indent',
            --         }
            --     end,
            -- }
        end,
    }

    -- other
    use { -- switch to English when leaving insert mode
        'lilydjwg/fcitx.vim',
        setup = function()
            vim.g.fcitx5_remote = 'fcitx5-remote'
        end,
        ft = { 'tex', 'markdown' },
    }
    use 'matveyt/vim-opera' -- range commands apply to part of line
    use { -- show and remove trailing whitespaces
        'jdhao/whitespace.nvim',
        event = 'VimEnter',
    }
    use { -- session manager
        'Shatur/neovim-session-manager',
        requires = { { 'nvim-lua/plenary.nvim' } },
    }
    use { -- macro manager
        'svermeulen/vim-macrobatics',
        requires = { { 'tpope/vim-repeat' } },
        config = function()
            vim.g.Mac_NamedMacrosDirectory = '~/.config/nvim/macrobatics'

            vim.keymap.set('n', 'q', '<plug>(Mac_Play)', { nowait = true })
            vim.keymap.set('n', 'gq', '<plug>(Mac_RecordNew)', { nowait = true })

            vim.keymap.set('n', '<leader>mh', function() vim.cmd('DisplayMacroHistory') end)

            vim.keymap.set('n', '[m', '<plug>(Mac_RotateBack)')
            vim.keymap.set('n', ']m', '<plug>(Mac_RotateForward)')

            -- move to three macros
            vim.keymap.set('n', '<leader>mq', '"q<plug>(Mac_CopyCurrentMacroToRegister)')
            vim.keymap.set('n', '<leader>mw', '"w<plug>(Mac_CopyCurrentMacroToRegister)')
            vim.keymap.set('n', '<leader>me', '"e<plug>(Mac_CopyCurrentMacroToRegister)')

            -- playback three macros
            vim.keymap.set('n', 'QQ', '"q<plug>(Mac_Play)')
            vim.keymap.set('n', 'QW', '"w<plug>(Mac_Play)')
            vim.keymap.set('n', 'QE', '"e<plug>(Mac_Play)')
        end,
    }
end)
