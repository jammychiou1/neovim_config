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

vim.keymap.set(
    { 'o' },
    'z',
    function()
        hop.hint_char2()
    end,
    { noremap = true }
)
