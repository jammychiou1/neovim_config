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

-- Hop motion
wk.register({
    ['^'] = {
        function()
            require('hop').hint_lines_skip_whitespace()
        end,
        'Hop line',
    },
    ['m'] = {
        function()
            require('hop').hint_words()
        end,
        'Hop word',
    },
    ['M'] = {
        function()
            require('hop').hint_words({
                hint_position = require 'hop.hint'.HintPosition.END,
            })
        end,
        'Hop end of word',
    },
}, {
    mode = { 'n', 'x', 'o' },
})

vim.keymap.set(
    'n', '(', function()
        vim.cmd('BufferLineCyclePrev')
    end, { desc = 'Previous buffer' }
)

vim.keymap.set(
    'n', ')', function()
        vim.cmd('BufferLineCycleNext')
    end, { desc = 'Next buffer' }
)

-- UI related
wk.register({
    ['<leader>u'] = {
        name = '+Toggle UI',
        d = {
            function()
                require("nvim-tree.api").tree.toggle()
            end,
            'Toggle directory viewer',
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
    },
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
    q = {
        '<plug>(Mac_Play)',
        'Execute macro',
    },
    gq = {
        '<plug>(Mac_RecordNew)',
        'Record new macro',
    },
})
