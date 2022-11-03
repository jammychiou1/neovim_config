local hop = require('hop')

hop.setup()

-- remap S to sneak
vim.keymap.set(
    { 'n', 'v', 'o' },
    'S',
    function()
        hop.hint_char2()
    end,
    { noremap = true }
)
