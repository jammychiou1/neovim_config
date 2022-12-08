local hop = require('hop')

hop.setup()

-- remap s to sneak
vim.keymap.set(
    { 'n', 'v' },
    's',
    function()
        hop.hint_char2()
    end,
    { noremap = true }
)

-- remap z to sneak for operator mode
vim.keymap.set(
    { 'o' },
    'z',
    function()
        hop.hint_char2()
    end,
    { noremap = true }
)

-- remap e to hop word
vim.keymap.set(
    { 'n', 'v' },
    'e',
    function()
        hop.hint_words()
    end,
    { noremap = true }
)

-- remap E to hop line
vim.keymap.set(
    { 'n', 'v' },
    'E',
    function()
        hop.hint_lines()
    end,
    { noremap = true }
)
