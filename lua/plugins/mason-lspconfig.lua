local ml = require('mason-lspconfig')

ml.setup({
    -- TODO: single language server list
    ensure_installed = {
        'clangd',
        -- no language server for make yet
        'cmake',
        'gopls',
        'pyright',
        'sumneko_lua',
        'bashls',
        'marksman',
        'texlab',
        'tsserver',
        'html',
        'svlangserver',
    },
})
