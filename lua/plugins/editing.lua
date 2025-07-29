-- editing, movement and text objects
return {
    {
        -- auto parentheses pairing
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        opts = { fast_wrap = {} }
    },
    {
        -- manipulating parentheses, brackets, quotes, etc.
        'kylechui/nvim-surround',
        event = "BufRead",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    },
    {
        -- replace with register
        'gbprod/substitute.nvim',
        lazy = true,
        config = true
    },
    {
        -- easy motion
        'phaazon/hop.nvim',
        branch = 'v2', -- optional but strongly recommended
        lazy = true,
        config = function()
            require('hop').setup({
                jump_on_sole_occurrence = false,
            })
        end,
    },
    {
        "LeonHeidelbach/trailblazer.nvim",
        event = "BufRead",
        config = function()
            require("trailblazer").setup()
        end,
    },
    {
        -- fast insert mode exit
        'max397574/better-escape.nvim',
        event = "InsertEnter",
        config = function()
            require('better_escape').setup()
        end,
    },
    {
        -- more text objects
        'wellle/targets.vim',
        event = "BufRead",
    },
    {
        -- range commands apply to part of line
        'matveyt/vim-opera',
        event = "BufRead",
    },
    {
        -- macro manager
        'svermeulen/vim-macrobatics',
        dependencies = { 'tpope/vim-repeat' },
        event = "BufRead",
        init = function()
            vim.g.Mac_NamedMacrosDirectory = vim.fn.stdpath("config") .. "/macrobatics"
        end,
    },
    {
        'ojroques/nvim-osc52',
        cond = function()
            return vim.env['SSH_CLIENT'] ~= nil
        end,
        config = function()
            local handler = function()
                if vim.v.event.regname == '' then
                    require('osc52').copy_register('"')
                end
            end
            vim.api.nvim_create_autocmd('TextYankPost', { callback = handler })
        end,
    },
}
