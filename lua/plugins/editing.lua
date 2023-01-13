-- editing, movement and text objects
return {
    { -- manipulating parentheses, brackets, quotes, etc.
        'machakann/vim-sandwich',
        init = function()
            vim.g.sandwich_no_default_key_mappings = 1
            vim.g.operator_sandwich_no_default_key_mappings = 1
            vim.g.textobj_sandwich_no_default_key_mappings = 1
        end,
        config = function()
            vim.cmd('runtime macros/sandwich/keymap/surround.vim')
        end
    },
    { -- auto parentheses pairing
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        opts = { fast_wrap = {} }
    },
    { -- replace with register
        'gbprod/substitute.nvim',
        keys = {
            { "s", function() require('substitute').operator() end, mode = "n", desc = "Substitute" },
            { "ss", function() require('substitute').operator() end, mode = "n", desc = "Substitute" },
            { "S", function() require('substitute').eol() end, mode = "n", desc = "Substitute" },
            { "s", function() require('substitute').visual() end, mode = "x", desc = "Substitute" },
        },
        config = function()
            require('substitute').setup()
        end
    },
    { -- new delete operation
        'svermeulen/vim-cutlass',
        config = function()
            local function noremap(modes, maps)
                for lhs, rhs in pairs(maps) do
                    vim.keymap.set(modes, lhs, rhs, { noremap = true })
                end
            end

            -- normal mode
            noremap('n', {
                ['x'] = 'd', -- x{motion}           => cut text over {motion}
                ['xx'] = 'dd', -- xx                => cut this line
                ['X'] = 'D', -- X                   => cut to end of line
            })

            -- visual mode
            noremap('x', {
                ['x'] = 'd', -- {Visual}x           => cut highlighted text
            })

        end,
        -- keys = {
        --     { "x", "d", mode = "n", noremap = true, desc = "Cut" },
        --     { "xx", "dd", mode = "n", noremap = true, desc = "Cut" },
        --     { "X", "D", mode = "n", noremap = true, desc = "Cut" },
        --     { "x", "d", mode = "x", noremap = true, desc = "Cut" },
        -- },
    },
    { -- easy motion
        'phaazon/hop.nvim',
        branch = 'v2', -- optional but strongly recommended
        -- TODO: lazy load
        -- lazy = false,
        config = function()
            local hop = require('hop')

            hop.setup()

            -- remap e to hop word
            vim.keymap.set(
                { 'n', 'x', 'o' },
                'e',
                function()
                    hop.hint_words()
                end
            )

            -- remap E to hop line
            vim.keymap.set(
                { 'n', 'x', 'o' },
                'E',
                function()
                    hop.hint_lines_skip_whitespace()
                end
            )

            local bar = '\\|'
            local punct = '[[:punct:]]'
            local alph_word = '[[:alpha:]]\\+'
            local dig_word = '[[:digit:]]\\+'
            local space_word = '[[:space:]]\\+'
            local re = punct .. bar .. alph_word .. bar .. dig_word .. bar .. space_word

            local no_offset = {
                current_line_only = true,
            }
            local offset = {
                current_line_only = true,
                hint_offset = 1,
                hint_position = require 'hop.hint'.HintPosition.END
            }

            vim.keymap.set(
                { 'n', 'x', 'o' },
                '<Tab>',
                function()
                    hop.hint_patterns(no_offset, re)
                end
            )

            vim.keymap.set(
                { 'i' },
                '<Tab>',
                function()
                    hop.hint_patterns(offset, re)
                end
            )

            vim.keymap.set(
                { 'n', 'x', 'o', 'i' },
                '<S-Tab>',
                function()
                    hop.hint_patterns(no_offset, re)
                end
            )
        end
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

            -- also exit terminal mode using <C-j><C-j>
            vim.keymap.set('t', '<C-j><C-j>', '<C-\\><C-n>', { noremap = true })
        end,
    },
    'wellle/targets.vim', -- more text objects
    'matveyt/vim-opera', -- range commands apply to part of line
    { -- macro manager
        'svermeulen/vim-macrobatics',
        dependencies = { 'tpope/vim-repeat' },
        -- init = function()
        --     vim.g.Mac_NamedMacrosDirectory = '~/.config/nvim/macrobatics'
        -- end,
        config = function()
            vim.keymap.set('n', 'q', '<plug>(Mac_Play)', { nowait = true })
            vim.keymap.set('n', 'gq', '<plug>(Mac_RecordNew)', { nowait = true })

            vim.keymap.set('n', '<leader>mh', function() vim.cmd('DisplayMacroHistory') end)

            vim.keymap.set('n', '[m', '<plug>(Mac_RotateBack)')
            vim.keymap.set('n', ']m', '<plug>(Mac_RotateForward)')
        end,
    },
}
