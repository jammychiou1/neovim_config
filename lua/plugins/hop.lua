local hop = require('hop')
local hint = require('hop.hint')

hop.setup()

-- remap s to sneak
vim.keymap.set(
    { 'n', 'v' },
    's',
    function()
        hop.hint_char2()
    end
)

-- remap z to sneak for operator mode
vim.keymap.set(
    { 'o' },
    'z',
    function()
        hop.hint_char2()
    end
)

-- remap e to hop word
vim.keymap.set(
    { 'n', 'v', 'o' },
    'e',
    function()
        hop.hint_words()
    end
)

-- remap E to hop line
vim.keymap.set(
    { 'n', 'v', 'o' },
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

local before = {
    direction = hint.HintDirection.BEFORE_CURSOR,
    current_line_only = true,
}
local after = {
    direction = hint.HintDirection.AFTER_CURSOR,
    current_line_only = true,
    hint_offset = 1,
    hint_position = require'hop.hint'.HintPosition.END
}

vim.keymap.set(
    { 'n', 'i' },
    '<Tab>',
    function()
        hop.hint_patterns(after, re)
    end
)

vim.keymap.set(
    { 'n', 'i' },
    '<S-Tab>',
    function()
        hop.hint_patterns(before, re)
    end
)
