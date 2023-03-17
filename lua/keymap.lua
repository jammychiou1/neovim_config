local wk = require("which-key")

-- Editing
-- TODO: fix xx, dd, cc, ss
wk.register({
    x = { 'd', 'Cut' },
    xx = { 'dd', 'Cut line' },
    X = { 'D', 'Cut to end of line' },
    d = { '"_d', 'Delete' },
    dd = { '"_dd', 'Delete line' },
    D = { '"_D', 'Delete to end of line' },
    c = { '"_c', 'Change' },
    cc = { '"_cc', 'Change line' },
    C = { '"_C', 'Change to end of line' },
    s = { function() require('substitute').operator() end, 'Substitute' },
    ss = { function() require('substitute').line() end, 'Substitute line' }, -- nmapping '_' (start of line) breaks this
    S = { function() require('substitute').eol() end, 'Substitute to end of line' },
})

wk.register({
    x = { 'd', 'Cut' },
    d = { '"_d', 'Delete' },
    c = { '"_c', 'Change' },
    s = { function() require('substitute').operator() end, 'Substitute' },
}, {
    mode = { 'x' },
})

wk.register({
    ['<RightMouse>'] = { '<LeftMouse>.', 'Repeat' },
}, {
    noremap = false,
})

-- Movements
wk.register({
    H = { '^', 'Start of line' },
    L = { '$', 'End of line' },
}, {
    mode = { 'n', 'x', 'o' },
})

-- Text Object
-- wk.register({
--     ['m'] = {
--         "<cmd>lua require('tsht').nodes()<CR>",
--         'Syntax Node',
--     },
-- }, {
--     mode = { 'x', 'o' },
-- })

-- The above doesn't work for some unknown reason
-- Maybe whichkey xmap is not working correctly
vim.cmd("omap     <silent> <CR> :<C-U>lua require('tsht').nodes()<CR>")
vim.cmd("xnoremap <silent> <CR> :lua require('tsht').nodes()<CR>")

wk.register({
    ['<CR>'] = {
        'v<CR>',
        'Select node',
    },
}, {
    mode = { 'n' },
    noremap = false,
})

-- Hop motion
wk.register({
    ['^'] = {
        function()
            require('hop').hint_lines_skip_whitespace()
        end,
        'Hop line',
    },
    ['e'] = {
        function()
            require('hop').hint_words()
        end,
        'Hop word',
    },
    ['E'] = {
        function()
            require('hop').hint_words({
                hint_position = require 'hop.hint'.HintPosition.END,
            })
        end,
        'Hop end of word',
    },
    -- ['m'] = {
    --     function()
    --         require('tsht').move({ side = "start" })
    --     end,
    --     'Hop node',
    -- },
    -- ['M'] = {
    --     function()
    --         require('tsht').move({ side = "end" })
    --     end,
    --     'Hop end of node',
    -- },
}, {
    mode = { 'n', 'x', 'o' },
})

local bar = '\\|'
local punct = '[[:punct:]]'
local alph_word = '[[:alpha:]]\\+'
local dig_word = '[[:digit:]]\\+'
local space_word = '[[:space:]]\\+'
local re = punct .. bar .. alph_word .. bar .. dig_word .. bar .. space_word

wk.register({
    ['<Tab>'] = {
        function()
            require('hop').hint_patterns({
                current_line_only = true,
                hint_offset = 1,
                hint_position = require 'hop.hint'.HintPosition.END
            }, re)
        end,
        'Hop in line'
    },
    ['<S-Tab>'] = {
        function()
            require('hop').hint_patterns({
                current_line_only = true,
            }, re)
        end,
        'Hop in line',
    },
}, {
    mode = { 'i' },
})

wk.register({
    ['<Tab>'] = {
        function()
            require('hop').hint_patterns({
                current_line_only = true,
                --hint_offset = 1,
                hint_position = require 'hop.hint'.HintPosition.END
            }, re)
        end,
        'Hop in line'
    },
    ['<S-Tab>'] = {
        function()
            require('hop').hint_patterns({
                current_line_only = true,
            }, re)
        end,
        'Hop in line',
    },
}, {
    mode = { 'n', 'x', 'o' },
})

wk.register({
    ["<C-w>"] = {
        name = "+Windowing",
        t = {
            function()
                vim.cmd('tabnew')
            end,
            'Open new tab'
        },
    },
})

-- UI related
wk.register({
    ['<leader>u'] = {
        name = '+Toggle UI',
        t = {
            function()
                vim.cmd("TroubleToggle")
            end,
            'Toggle trouble list',
        },
        d = {
            function()
                require("nvim-tree.api").tree.toggle()
            end,
            'Toggle directory viewer',
        },
        o = {
            function()
                vim.cmd("Lspsaga outline")
            end,
            'Toggle LSP outline',
        },
    },
    ['<leader>t'] = {
        name = '+ToggleTerm',
        t = {
            function()
                vim.cmd("ToggleTerm direction=tab")
            end,
            'ToggleTerm in new tab',
        },
        v = {
            function()
                vim.cmd("ToggleTerm direction=vertical size=40")
            end,
            'ToggleTerm in vertical split',
        },
        f = {
            function()
                vim.cmd("ToggleTerm direction=float")
            end,
            'ToggleTerm in floating window',
        },
    },
    ['<leader>f'] = {
        name = '+File',
        f = {
            function()
                require('telescope.builtin').find_files()
            end,
            'Find file',
        },
        g = {
            function()
                require('telescope.builtin').live_grep()
            end,
            'Find word',
        },
        b = {
            function()
                require('telescope.builtin').buffers()
            end,
            'Find buffer',
        },
        h = {
            function()
                require('telescope.builtin').help_tags()
            end,
            'Find help tag',
        },
        o = {
            function()
                require('telescope.builtin').oldfiles()
            end,
            'Recent files',
        },
        n = {
            function()
                require('startup').new_file()
            end,
            'New file',
        },
    },
    ['<leader>r'] = {
        name = '+Register',
        p = {
            function()
                require('telescope').extensions.neoclip.default()
            end,
            'Pick for plus register',
        },
    },
    ['<leader>s'] = {
        name = '+Session',
        o = {
            function()
                require('telescope').extensions.possession.list()
            end,
            'Open session',
        }
    },
})

-- LSP related
wk.register({
    ['<space>'] = {
        name = '+LSP actions',
        ca = {
            function()
                vim.cmd("Lspsaga code_action")
            end,
            "Code action",
        },
        ci = {
            function()
                vim.cmd("Lspsaga incoming_calls")
            end,
            "Incoming calls",
        },
        co = {
            function()
                vim.cmd("Lspsaga outgoing_calls")
            end,
            "Outgoing calls",
        },
        rn = {
            function()
                vim.cmd("Lspsaga rename")
            end,
            "Rename variable",
        },
        f = {
            function()
                vim.lsp.buf.format()
            end,
            "Format file",
        },
        sn = {
            function()
                vim.cmd("ISwapNode")
            end,
            'Interactively swap node',
        },
    },
    g = {
        h = {
            function()
                -- Lsp finder find the symbol definition implement reference
                -- if there is no implement it will hide
                -- when you use action in finder like open vsplit then you can
                -- use <C-t> to jump back
                vim.cmd("Lspsaga lsp_finder")
            end,
            "LSP finder",
        },
        d = {
            function()
                -- Peek Definition
                -- you can edit the definition file in this flaotwindow
                -- also support open/vsplit/etc operation check definition_action_keys
                -- support tagstack C-t jump back
                vim.cmd("Lspsaga peek_definition")
            end,
            "Peek definition",
        },
    },
    K = {
        function()
            vim.cmd("Lspsaga hover_doc")
        end,
        "Show LSP Hover",
    },
})

-- wk.register({
--     ['<space>'] = {
--         name = '+LSP actions',
--         rr = {
--             function()
--                 require('refactoring').select_refactor()
--             end,
--             "Refactor",
--         },
--     },
-- }, {
--     mode = { 'x' }
-- })

-- The above doesn't work for some unknown reason
-- Maybe whichkey xmap is not working correctly
vim.api.nvim_set_keymap(
    "x",
    "<space>rr",
    ":lua require('refactoring').select_refactor()<CR>",
    { noremap = true, silent = true }
)

wk.register({
    ['<space>'] = {
        sr = {
            -- not really LSP based, but kinda fits here
            function()
                require("ssr").open()
            end,
            "Structural replace",
        },
    },
}, {
    mode = { 'n', 'x' }
})
-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
-- vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
-- vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

-- Terminal mode maps
wk.register({
    ['<C-j><C-j>'] = {
        [[<C-\><C-n>]],
        "Fast exit"
    }
}, {
    mode = 't',
})

-- Insert mode maps
wk.register({
    -- fast hjkl in insert mode
    -- see https://neovim.io/news/2022/04#distinguishing-modifier-keys
    -- and http://www.leonerd.org.uk/hacks/fixterms/
    ['<C-h>'] = { '<Left>', 'Left' },
    ['<C-j>'] = { '<Down>', 'Down' },
    ['<C-k>'] = { '<Up>', 'Up' },
    ['<C-l>'] = { '<Right>', 'Right' },
    ['<C-v>'] = { '<C-r>+', 'Paste' },
}, {
    mode = 'i',
})

-- Macro related
wk.register({
    -- ['<leader>m'] = {
    --     -- name = '+Macro management',
    --     -- h = {
    --     --     function()
    --     --         vim.cmd('DisplayMacroHistory')
    --     --     end,
    --     --     "Show macro history",
    --     -- },
    --     -- p = {
    --     --     '<plug>(Mac_RotateBack)',
    --     --     "Rotate to previous macro",
    --     -- },
    --     -- n = {
    --     --     '<plug>(Mac_RotateForward)',
    --     --     "Rotate to next macro",
    --     -- },
    -- },
    q = {
        '<plug>(Mac_Play)',
        'Execute macro',
    },
    gq = {
        '<plug>(Mac_RecordNew)',
        'Record new macro',
    },
})

-- vimtex
wk.register({
    ['<leader>l'] = {
        name = '+vimtex',
        l = {
            '<plug>(vimtex-compile)',
            'Toggle compiling',
        },
        v = {
            '<plug>(vimtex-view)',
            'Preview PDF',
        },
        c = {
            '<plug>(vimtex-clean)',
            'Clean up auxiliary files',
        },
        q = {
            '<plug>(vimtex-log)',
            'Clean up auxiliary files',
        },
        p = {
            function()
                require("nabla").popup()
            end,
            "Preview math",
        },
    },
})
