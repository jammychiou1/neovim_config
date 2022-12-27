-- remember to run PackerCompile after modifying this file

require('packer').startup(function(use)

    -- packer manages itself
    use 'wbthomason/packer.nvim'

    -- editing, movement and text objects
    use {
        'machakann/vim-sandwich', -- manipulating parentheses, brackets, quotes, etc.
        config = function()
            vim.api.nvim_command 'runtime macros/sandwich/keymap/surround.vim'
        end
    }
    use {
        'gbprod/substitute.nvim',
        config = function()

            local substitute = require('substitute')
            substitute.setup()

            local set = vim.keymap.set;
            set('n', 'r', substitute.operator)
            set('n', 'rr', substitute.line)
            set('x', 'r', substitute.visual)

            set('n', 'R', 'r', { noremap = true })
            set('x', 'R', 'r', { noremap = true })
        end
    }
    use { -- new delete operation
        'svermeulen/vim-cutlass',
        config = function()
            require('plugins.vim-cutlass')
        end,
    }
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
    use {
        'windwp/nvim-autopairs',
        config = function()
            require('nvim-autopairs').setup({
                fast_wrap = {},
            })
        end
    }
    use 'wellle/targets.vim'

    -- file finding
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        requires = 'nvim-lua/plenary.nvim',
        -- remember to install ripgrep
    }

    -- snippets
    use 'L3MON4D3/LuaSnip' -- snippet engine
    -- use 'rafamadriz/friendly-snippets' -- useful snippets

    -- auto completion
    use { -- completion engine
        'hrsh7th/nvim-cmp',
        after = 'LuaSnip',
        config = function()
            require('plugins.nvim-cmp')
        end,
    }
    -- completion sources
    use {
        'hrsh7th/cmp-nvim-lsp',
        after = 'nvim-cmp',
    }
    use {
        'hrsh7th/cmp-buffer',
        after = 'nvim-cmp',
    }
    use {
        'hrsh7th/cmp-path',
        after = 'nvim-cmp',
    }
    use {
        'hrsh7th/cmp-nvim-lsp-signature-help',
        after = 'nvim-cmp',
    }
    use {
        'saadparwaiz1/cmp_luasnip',
        after = 'nvim-cmp',
    }

    -- lsp stuff
    use { -- auto install lsp & other servers
        'williamboman/mason.nvim',
        config = function()
            require('mason').setup()
        end,
    }
    use { -- auto config lsp servers
        'williamboman/mason-lspconfig.nvim',
        after = 'mason.nvim',
        config = function()
            require('plugins.mason-lspconfig')
        end,
    }
    use {
        'neovim/nvim-lspconfig',
        after = 'cmp-nvim-lsp',
        config = function()
            require('plugins.nvim-lspconfig')
        end,
    }

    -- latex stuff
    use {
        'lervag/vimtex',
        ft = 'tex',
        config = function()
            -- vim.opt.conceallevel = 2
        end,
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
    use {
        'EdenEast/nightfox.nvim',
        config = function()
            require('nightfox').setup {
                specs = {
                    carbonfox = {
                        syntax = {
                            field = "#7dd759"
                        }
                    }
                },
                groups = {
                    carbonfox = {
                        ['@parameter'] = { link = "@field" },
                    }
                }
            }
            vim.api.nvim_command('colorscheme carbonfox')
        end
    }
    -- for future reference
    -- require('nightfox').setup {
    --     palettes = {
    --         carbonfox = {
    --             -- yellow = { base = "#ccbb53", bright = "#e0d697", dim = "#8e823a" },
    --             -- orange = { base = "#e78d28", bright = "#f0ba7e", dim = "#a1621c" },
    --         }
    --     },
    --     specs = {
    --         carbonfox = {
    --             syntax = {
    --                 field = "#7dd759"
    --             }
    --         }
    --     },
    --     groups = {
    --         carbonfox = {
    --             -- Structure = { fg = '#64648c' },
    --             -- ['@field'] = { fg = 'palette.yellow.bright' },
    --             -- ['@parameter'] = { fg = '#e499bd' },
    --             ['@parameter'] = { link = "@field" },
    --         }
    --     }
    -- }
    use { -- fancy statusline, remember to install patch fonts https://www.nerdfonts.com/#home
        'nvim-lualine/lualine.nvim',
        after = 'nightfox.nvim',
        config = function()
            require('lualine').setup()
        end,
    }
    use { -- fancy buffer line
        'akinsho/bufferline.nvim',
        after = 'nightfox.nvim',
        tag = 'v3.*',
        config = function()
            require('bufferline').setup({
                options = {
                    mode = 'tabs',
                },
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
            require('nvim-treesitter.configs').setup {
                highlight = {
                    enable = false
                },
            }
        end
    }
    use {
        'nvim-treesitter/nvim-treesitter-textobjects',
        after = 'nvim-treesitter',
        config = function()
            require('nvim-treesitter.configs').setup {
                textobjects = {
                    move = {
                        enable = true,
                        set_jumps = true, -- whether to set jumps in the jumplist
                        goto_next_start = {
                            [']]'] = { query = '@function.outer', desc = 'Next function start' },
                        },
                        goto_next_end = {
                            [']['] = { query = '@function.outer', desc = 'Next function end' },
                        },
                        goto_previous_start = {
                            ['[['] = { query = '@function.outer', desc = 'Previous function start' },
                        },
                        goto_previous_end = {
                            ['[]'] = { query = '@function.outer', desc = 'Previous function end' },
                        },
                    },
                },
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
    use  'jdhao/whitespace.nvim' -- show and remove trailing whitespaces
    use { -- session manager
        'Shatur/neovim-session-manager',
        requires = 'nvim-lua/plenary.nvim',
    }
    use { -- macro manager
        'svermeulen/vim-macrobatics',
        requires = 'tpope/vim-repeat',
        config = function()
            vim.g.Mac_NamedMacrosDirectory = '~/.config/nvim/macrobatics'

            vim.keymap.set('n', 'q', '<plug>(Mac_Play)', { nowait = true })
            vim.keymap.set('n', 'gq', '<plug>(Mac_RecordNew)', { nowait = true })

            vim.keymap.set('n', '<leader>mh', function() vim.cmd('DisplayMacroHistory') end)

            vim.keymap.set('n', '[m', '<plug>(Mac_RotateBack)')
            vim.keymap.set('n', ']m', '<plug>(Mac_RotateForward)')
        end,
    }
    use { -- show keymap
        'folke/which-key.nvim',
        config = function()
            require('which-key').setup()
        end
    }
    use {
        'karb94/neoscroll.nvim',
        config = function()
            require('neoscroll').setup()
        end
    }
end)
