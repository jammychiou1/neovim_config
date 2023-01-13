-- colorscheme

-- ref: https://github.com/nullchilly/nvim/blob/nvim/lua/config/catppuccin.lua
local opts = {
    flavour = 'mocha', -- latte, frappe, macchiato, mocha
    term_colors = true,
    transparent_background = false,
    no_italic = false,
    no_bold = false,
    styles = {
        comments = {},
        conditionals = {},
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
    },
    color_overrides = {
        mocha = {
            base = '#000000',
            mantle = '#101010',
            crust = '#202020',
        },
    },
    highlight_overrides = {
        mocha = function(C)
            return {
                NvimTreeNormal = { bg = C.base },
                NvimTreeWinSeparator = { link = 'WinSeparator' },
                -- NvimTreeEndOfBuffer = { bg = '#080808', fg = '#080808' },
                Pmenu = { bg = C.mantle },
                LspSagaLightBulb = { fg = C.yellow },
            }
        end,
    },
}

return {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    priority = 1000,
    config = function()
        require('catppuccin').setup(opts)

        vim.cmd.colorscheme('catppuccin')
    end
}
