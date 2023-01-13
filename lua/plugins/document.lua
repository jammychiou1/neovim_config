-- editing documents (markdown and latex)
return {
    { -- latex stuff
        'lervag/vimtex',
        ft = 'tex',
        config = function()
            -- vim.opt.conceallevel = 2
        end,
    },
    { -- markdown stuff
        'iamcco/markdown-preview.nvim',
        ft = 'markdown',
        build = function()
            vim.fn['mkdp#util#install']()
        end,
    },
    { -- switch back to English when leaving insert mode
        'lilydjwg/fcitx.vim',
        ft = { 'tex', 'markdown' },
        init = function()
            vim.g.fcitx5_remote = 'fcitx5-remote'
        end,
    },
}
