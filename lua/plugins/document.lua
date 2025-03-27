-- editing documents (markdown and latex)
return {
    { -- latex stuff
        'lervag/vimtex',
        ft = 'tex',
        init = function()
            vim.g.vimtex_mappings_enabled = false
            vim.g.vimtex_matchparen_enabled = false
            vim.g.vimtex_imaps_enabled = false
            vim.g.vimtex_compiler_enabled = false
        end,
    },
}
