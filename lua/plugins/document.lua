-- editing documents (markdown and latex)
return {
    { -- latex stuff
        'lervag/vimtex',
        ft = 'tex',
        init = function()
            vim.g.vimtex_compiler_enabled = false
        end,
    },
}
