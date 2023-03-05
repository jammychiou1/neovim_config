-- editing, movement and text objects
return {
    { -- auto parentheses pairing
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        opts = { fast_wrap = {} }
    },
    { -- manipulating parentheses, brackets, quotes, etc.
        'kylechui/nvim-surround',
        event = "BufRead",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
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
        config = function()
            require('hop').setup({
                jump_on_sole_occurrence = false,
            })
        end,
    },
    {
        "cshuaimin/ssr.nvim",
        lazy = true,
    },
    {
        'mfussenegger/nvim-treehopper',
        dependencies = {
            'phaazon/hop.nvim',
        },
        lazy = true,
        config = function()
            local keys = 'asdghklqwertyuiopzxcvbnmfj' -- this is the default for hop.nvim
            local keys_arr = {}
            for i = 1, #keys do
                local c = keys:sub(i, i)
                keys_arr[i] = c
            end
            require("tsht").config.hint_keys = keys_arr
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
        'Wansmer/sibling-swap.nvim',
        lazy = true,
        config = function()
            require('sibling-swap').setup({
                use_default_keymaps = false,
            })
        end,
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
    -- {
    --     "smjonas/snippet-converter.nvim",
    --     -- SnippetConverter uses semantic versioning. Example: use version = "1.*" to avoid breaking changes on version 1.
    --     -- Uncomment the next line to follow stable releases only.
    --     -- tag = "*",
    --     cmd = "ConvertSnippets",
    --     config = function()
    --         local template = {
    --             -- name = "t1", (optionally give your template a name to refer to it in the `ConvertSnippets` command)
    --             sources = {
    --                 ultisnips = {
    --                     vim.fn.stdpath("config") .. "/latex-snippets/tex.snippets",
    --                 },
    --             },
    --             output = {
    --                 -- Specify the output formats and paths
    --                 vscode_luasnip = {
    --                     vim.fn.stdpath("config") .. "/luasnip_snippets",
    --                 },
    --             },
    --         }

    --         require("snippet_converter").setup {
    --             templates = { template },
    --         }
    --     end
    -- },
}
