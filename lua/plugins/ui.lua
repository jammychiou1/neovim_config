-- UI plugins
return {
    'kyazdani42/nvim-web-devicons', -- nerd font icons
    'nvim-lua/plenary.nvim', -- helper plugin required by many UI plugins

    { -- fancy statusline
        'nvim-lualine/lualine.nvim',
        config = function()
            require('lualine').setup({
                extensions = {
                    'nvim-tree',
                    'toggleterm',
                }
            })
        end,
    },
    { -- fancy tab line
        'akinsho/bufferline.nvim',
        config = function()
            require('bufferline').setup({})
        end,
    },
    { -- indent guide
        "lukas-reineke/indent-blankline.nvim",
        event = "BufRead",
    },
    { -- show and remove trailing whitespaces
        'jdhao/whitespace.nvim',
        event = "BufRead",
    },
    { -- fancy prompts for input/selection
        'stevearc/dressing.nvim',
        event = "VeryLazy",
    },
    { -- fancy notifications
        'rcarriga/nvim-notify',
        event = "VeryLazy",
        config = function()
            vim.notify = require("notify")
        end,
    },
    { -- directory viewer
        'nvim-tree/nvim-tree.lua',
        init = function()
            -- disable netrw at the very start of your init.lua (strongly advised)
            -- reference: https://github.com/nvim-tree/nvim-tree.lua
            vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1
        end,
        config = true,
    },
    { -- show keymap
        'folke/which-key.nvim',
        lazy = true,
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            require("which-key").setup()
        end,
    },
    { -- scroll animation
        'karb94/neoscroll.nvim',
        event = "BufRead",
        config = function()
            require('neoscroll').setup({
                easing_function = "quadratic" -- Default easing function
            })
        end
    },
    { -- persistent terminals
        "akinsho/toggleterm.nvim",
        version = '2.*',
        config = function()
            require("toggleterm").setup({
                open_mapping = [[<c-\>]],
                start_in_insert = true,
                insert_mappings = true,
                terminal_mappings = true,
                direction = 'float',
            })
        end
    },
    { -- session manager
        'jedrzejboczar/possession.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        cmd = {
            'PossessionSave',
            'PossessionLoad',
            'PossessionClose',
            'PossessionDelete',
            'PossessionShow',
            'PossessionList',
            'PossessionMigrate',
        },
        event = "BufRead",
        config = function()
            require('possession').setup({})
            require('telescope').load_extension('possession')
        end,
    },
    { -- Bdelete
        'moll/vim-bbye',
        cmd = {
            'Bdelete',
            'Bwipeout',
        },
    },
}
