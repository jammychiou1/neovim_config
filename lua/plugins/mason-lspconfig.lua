local ml = require('mason-lspconfig')

ml.setup({
    ensure_installed = {
        'clangd',
        'pyright',
        'texlab',
        'sumneko_lua',
        'bashls',
        'marksman',
    },
})
