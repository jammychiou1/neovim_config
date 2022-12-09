local function noremap(modes, maps)
    for lhs, rhs in pairs(maps) do
        vim.keymap.set(modes, lhs, rhs, { noremap = true })
    end
end

-- normal mode
noremap('n', {
    ['x'] = 'd', -- x{motion}           => cut text over {motion}
    ['xx'] = 'dd', -- xx                => cut this line
    ['X'] = 'D', -- X                   => cut to end of line
})

-- visual mode
noremap('x', {
    ['x'] = 'd', -- {Visual}x           => cut highlighted text
})
