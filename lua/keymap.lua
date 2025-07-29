local wk = require("which-key")

-- Editing
-- TODO: fix xx, dd, cc, ss
wk.add({
    { 'x', 'd', desc = 'Cut' },
    { 'xx', 'dd', desc = 'Cut line' },
    { 'X', 'D', desc = 'Cut to end of line' },
    { 'd', '"_d', desc = 'Delete' },
    { 'dd', '"_dd', desc = 'Delete line' },
    { 'D', '"_D', desc = 'Delete to end of line' },
    { 'c', '"_c', desc = 'Change' },
    { 'cc', '"_cc', desc = 'Change line' },
    { 'C', '"_C', desc = 'Change to end of line' },
    { 's', function() require('substitute').operator() end, desc = 'Substitute' },
    { 'ss', function() require('substitute').line() end, desc = 'Substitute line' }, -- nmapping '_' (start of line) breaks this
    { 'S', function() require('substitute').eol() end, desc = 'Substitute to end of line' },
})

wk.add({
    {
        mode = { 'x' },
        {'x', 'd', desc = 'Cut' },
        {'d', '"_d', desc = 'Delete' },
        {'c', '"_c', desc = 'Change' },
        {'s', function() require('substitute').operator() end, desc = 'Substitute' },
    }
})

wk.add({
    { '<RightMouse>', '<LeftMouse>.', desc = 'Repeat', remap = true },
})

-- Movements
wk.add({
    { 'H', '^', desc = 'Start of line', mode = { 'n', 'x', 'o' } },
    { 'L', '$', desc = 'End of line', mode = { 'n', 'x', 'o' } },
})

-- Hop motion
wk.add({
    {
        mode = { 'n', 'x', 'o' },
        { '^', function() require('hop').hint_lines_skip_whitespace() end, desc = 'Hop line' },
        { 'm', function() require('hop').hint_words() end, desc = 'Hop word' },
        {
            'M', function()
                require('hop').hint_words({hint_position = require 'hop.hint'.HintPosition.END})
            end, desc = 'Hop end of word'
        },
    },
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
wk.add({
    { '<leader>u', group = 'Toggle UI' },
    {
        '<leader>ud',
        function()
            require("nvim-tree.api").tree.toggle()
        end,
        desc = 'Toggle directory viewer',
    },

    { '<leader>f', group = 'File' },
    {
        '<leader>ff',
        function()
            require('telescope.builtin').find_files()
        end,
        desc = 'Find file',
    },
    {
        '<leader>fg',
        function()
            require('telescope.builtin').live_grep()
        end,
        desc = 'Find word',
    },
    {
        '<leader>fh',
        function()
            require('telescope.builtin').help_tags()
        end,
        desc = 'Find help tag',
    },
    {
        '<leader>fo',
        function()
            require('telescope.builtin').oldfiles()
        end,
        desc = 'Recent files',
    },
})

-- Insert mode maps
wk.add({
    {
        mode = { 'i' },
        -- fast hjkl in insert mode
        -- see https://neovim.io/news/2022/04#distinguishing-modifier-keys
        -- and http://www.leonerd.org.uk/hacks/fixterms/
        {'<C-h>', '<Left>', desc = 'Left' },
        {'<C-j>', '<Down>', desc = 'Down' },
        {'<C-k>', '<Up>', desc = 'Up' },
        {'<C-l>', '<Right>', desc = 'Right' },
        {'<C-v>', '<C-r>+', desc = 'Paste' },
    },
})

-- Macro related
wk.add({
    { 'q', '<plug>(Mac_Play)', desc = 'Execute macro'},
    { 'gq', '<plug>(Mac_RecordNew)', desc = 'Record new macro'},
})
