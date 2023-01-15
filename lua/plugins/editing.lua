-- editing, movement and text objects
return {
    { -- auto parentheses pairing
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        opts = { fast_wrap = {} }
    },
    { -- manipulating parentheses, brackets, quotes, etc.
        'machakann/vim-sandwich',
        event = "BufRead",
        init = function()
            vim.g.sandwich_no_default_key_mappings = 1
            vim.g.operator_sandwich_no_default_key_mappings = 1
            vim.g.textobj_sandwich_no_default_key_mappings = 1
        end,
        config = function()
            vim.cmd('runtime macros/sandwich/keymap/surround.vim')
        end,

    },
    { -- replace with register
        'gbprod/substitute.nvim',
        lazy = true,
        config = true
    },
    { -- new delete operation
        'svermeulen/vim-cutlass',
        enabled = false,
        lazy = true,
    },
    { -- easy motion
        'phaazon/hop.nvim',
        branch = 'v2', -- optional but strongly recommended
        lazy = true,
        config = true
    },
    { -- fast insert mode exit
        'max397574/better-escape.nvim',
        event = "InsertEnter",
        config = function()
            require('better_escape').setup({
                keys = function()
                    return vim.api.nvim_win_get_cursor(0)[2] > 1 and '<esc>l' or '<esc>'
                end,
            })
        end,
    },
    { -- more text objects
        'wellle/targets.vim',
        event = "BufRead",
    },
    { -- range commands apply to part of line
        'matveyt/vim-opera',
        event = "BufRead",
    },
    { -- macro manager
        'svermeulen/vim-macrobatics',
        dependencies = { 'tpope/vim-repeat' },
        event = "BufRead",
        init = function()
            vim.g.Mac_NamedMacrosDirectory = vim.fn.stdpath("config") .. "/macrobatics"
        end,
    },
    {
        "AckslD/nvim-neoclip.lua",
        dependencies = { 'kkharji/sqlite.lua' },
        event = "BufRead",
        config = function()
            require('neoclip').setup()
        end,
    },
    {
        "cshuaimin/ssr.nvim",
        lazy = true,
    },
}
