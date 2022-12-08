local function noremap(modes, maps)
    for lhs, rhs in pairs(maps) do
        vim.keymap.set(modes, lhs, rhs, { noremap = true })
    end
end

-- remap ' to "
noremap({ 'n', 'v' }, { ["'"] = '"' })

-- normal mode
noremap('n', {
    ['x'] = 'd', -- x{motion}    => cut text that {motion} moves over
    ['xx'] = 'dd', -- xx           => cut this line
    ['X'] = 'D', -- X            => cut to end of line
})

-- visual mode
noremap('x', {
    ['x'] = 'd', -- {Visual}x    => cut highlighted text
})
