local cmp = require('cmp')

-- reference: https://github.com/community/community/discussions/29817
cmp.setup({
    mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-h>'] = cmp.mapping.close(),
        ['<C-j>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
        ['<C-k>'] = cmp.mapping(function(fallback)
            vim.api.nvim_feedkeys(
                vim.fn['copilot#Accept'](vim.api.nvim_replace_termcodes('<Tab>', true, true, true)),
                'n', true)
        end)
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'path' },
    },
})
