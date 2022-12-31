local hop = require('hop')

hop.setup()

-- -- remap s to sneak
-- vim.keymap.set(
--     { 'n', 'x' },
--     's',
--     function()
--         hop.hint_char2()
--     end
-- )
--
-- -- remap z to sneak for operator mode
-- vim.keymap.set(
--     { 'o' },
--     'z',
--     function()
--         hop.hint_char2()
--     end
-- )

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

-- make <C-i> work like original tab
-- see https://neovim.io/news/2022/04#distinguishing-modifier-keys
-- and http://www.leonerd.org.uk/hacks/fixterms/
vim.keymap.set(
    { 'i' },
    '<C-i>',
    '<Tab>',
    { noremap = true }
)
