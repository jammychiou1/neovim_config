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
    ss = { function() require('substitute').line() end, 'Substitute line' },
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

-- Movements
wk.register({
    H = { '_', 'Start of line' },
    L = { '$', 'End of line' },
}, {
    mode = { 'n', 'x', 'o' },
})

-- local hop = require('hop')
-- -- remap e to hop word
-- vim.keymap.set(
--     { 'n', 'x', 'o' },
--     'e',
--     function()
--         hop.hint_words()
--     end
-- )
--
-- -- remap E to hop line
-- vim.keymap.set(
--     { 'n', 'x', 'o' },
--     'E',
--     function()
--         hop.hint_lines_skip_whitespace()
--     end
-- )
--
-- local bar = '\\|'
-- local punct = '[[:punct:]]'
-- local alph_word = '[[:alpha:]]\\+'
-- local dig_word = '[[:digit:]]\\+'
-- local space_word = '[[:space:]]\\+'
-- local re = punct .. bar .. alph_word .. bar .. dig_word .. bar .. space_word
--
-- local no_offset = {
--     current_line_only = true,
-- }
-- local offset = {
--     current_line_only = true,
--     hint_offset = 1,
--     hint_position = require 'hop.hint'.HintPosition.END
-- }
--
-- vim.keymap.set(
--     { 'n', 'x', 'o' },
--     '<Tab>',
--     function()
--         hop.hint_patterns(no_offset, re)
--     end
-- )
--
-- vim.keymap.set(
--     { 'i' },
--     '<Tab>',
--     function()
--         hop.hint_patterns(offset, re)
--     end
-- )
--
-- vim.keymap.set(
--     { 'n', 'x', 'o', 'i' },
--     '<S-Tab>',
--     function()
--         hop.hint_patterns(no_offset, re)
--     end
-- )

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
        -- TODO: maybe add mason and lazy
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
    ['<leader>s'] = {
        name = '+Session',
        l = {
            function()
                vim.cmd("SessionManager load_session")
            end,
            'Load session',
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
                require('telescope.builtin').old_files()
            end,
            'Recent files',
        },
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
    ['<C-j>'] = { '<Right>', 'Right' },
    ['<C-k>'] = { '<Up>', 'Up' },
    ['<C-l>'] = { '<Down>', 'Down' },
}, {
    mode = 'i',
})
-- fast paste in insert mode
-- vim.keymap.set('i', '<M-a>', '<C-r>+', { noremap = true, desc = 'Fast paste' })

-- Macro related
wk.register({
    ['<leader>m'] = {
        name = '+Macro management',
        h = {
            function()
                vim.cmd('DisplayMacroHistory')
            end,
            "Show macro history",
        },
        p = {
            '<plug>(Mac_RotateBack)',
            "Rotate to previous macro",
        },
        n = {
            '<plug>(Mac_RotateForward)',
            "Rotate to next macro",
        },
    },
    q = {
        '<plug>(Mac_Play)',
        'Execute macro',
    },
    gq = {
        '<plug>(Mac_RecordNew)',
        'Record new macro',
    },
})