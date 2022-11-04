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

-- reference: https://github.com/jdhao/nvim-config/blob/master/lua/config/lsp.lua
--            :help mason-lspconfig.setup_handlers()

local my_on_attach = function(client, bufnr)

    local buf_map = function(modes, maps)
        for lhs, rhs in pairs(maps) do
            vim.keymap.set(modes, lhs, rhs, { buffer = bufnr })
        end
    end

    local lsp = vim.lsp

    buf_map('n', {
        ['gD'] = lsp.buf.declaration, -- go to declaration
        ['gd'] = lsp.buf.definition, -- go to definition
        ['gi'] = lsp.buf.implementation, -- go to implementation
        ['gr'] = lsp.buf.references, -- show references
        ['K'] = vim.lsp.buf.hover, -- show hover
        ['<C-k>'] = lsp.buf.signature_help, -- hint function signature
        ['<space>rn'] = lsp.buf.rename, -- rename variable
        ['<space>ca'] = lsp.buf.code_action, -- code action
    })

    if client.server_capabilities.documentFormattingProvider then
        buf_map('n', {
            ['<space>f'] = lsp.buf.format -- format code
        })
    end

end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- latexindent config is complicated
-- vim.fn.expand does not recognize '${HOME}'
local latexindent_config_file = vim.fn.expand('$HOME/.config/nvim/indentSetting.yaml')

ml.setup_handlers({

    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.

    function(server_name) -- default handler (optional)

        require('lspconfig')[server_name].setup({
            capabilities = capabilities,
            on_attach = my_on_attach,
        })

    end,


    -- Next, you can provide a dedicated handler for specific servers.
    -- For example, a handler override for the `rust_analyzer`:

    ['texlab'] = function ()

        require('lspconfig').texlab.setup({
            capabilities = capabilities,
            on_attach = my_on_attach,
            settings = {
                texlab = {
                    latexindent = {
                        ['local'] = latexindent_config_file,
                    },
                },
            },
        })

    end

})
