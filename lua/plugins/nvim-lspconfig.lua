-- reference: https://github.com/jdhao/nvim-config/blob/master/lua/config/lsp.lua
--            :help mason-lspconfig.setup_handlers()

-- TODO: single config
local servers = {
    'clangd',
    'pyright',
    'texlab',
    'sumneko_lua',
    'bashls',
    'marksman',
}

local my_on_attach = function(client, bufnr)

    local buf_map = function(modes, maps)
        for lhs, rhs in pairs(maps) do
            vim.keymap.set(modes, lhs, rhs, { buffer = bufnr })
        end
    end

    local lsp = vim.lsp

    buf_map('n', {
        ['gD'] = function() vim.cmd('tab split'); vim.lsp.buf.declaration() end, -- go to declaration
        ['gd'] = function() vim.cmd('tab split'); vim.lsp.buf.definition() end, -- go to definition
        -- ['gD'] = lsp.buf.declaration, -- go to declaration
        -- ['gd'] = lsp.buf.definition, -- go to definition
        -- ['gi'] = lsp.buf.implementation, -- go to implementation
        -- ['gR'] = lsp.buf.references, -- show references
        ['K'] = vim.lsp.buf.hover, -- show hover
        ['<C-k>'] = lsp.buf.signature_help, -- hint function signature
        ['<space>rn'] = lsp.buf.rename, -- rename variable
        ['<space>ca'] = lsp.buf.code_action, -- code action
    })

    local caps = client.server_capabilities

    if caps.documentFormattingProvider then
        buf_map('n', {
            ['<space>f'] = lsp.buf.format -- format code
        })
    end

    -- reference: https://github.com/theHamsta/nvim-semantic-tokens
    if caps.semanticTokensProvider and caps.semanticTokensProvider.full then
        local augroup = vim.api.nvim_create_augroup('SemanticTokens', {})
        vim.api.nvim_create_autocmd('TextChanged', {
            group = augroup,
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.semantic_tokens_full()
            end,
        })
        -- fire it first time on load as well
        vim.lsp.buf.semantic_tokens_full()
    end

end

local function generate_capabilities()
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true
    }

    return capabilities
end

for _, server_name in pairs(servers) do
    local settings = {}
    if server_name == 'texlab' then
        settings = {
            texlab = {
                latexindent = {
                    -- latexindent config is complicated
                    -- vim.fn.expand does not recognize '${HOME}'
                    ['local'] = vim.fn.expand('$HOME/.config/nvim/indentSetting.yaml')
                },
            },
        }
    end
    require('lspconfig')[server_name].setup({
        capabilities = generate_capabilities(),
        on_attach = my_on_attach,
        settings = settings,
    })
end

-- ml.setup_handlers({
--
--     -- The first entry (without a key) will be the default handler
--     -- and will be called for each installed server that doesn't have
--     -- a dedicated handler.
--
--     function(server_name) -- default handler (optional)
--
--         require('lspconfig')[server_name].setup({
--             capabilities = generate_capabilities(),
--             on_attach = my_on_attach,
--         })
--
--     end,
--
--     -- Next, you can provide a dedicated handler for specific servers.
--     -- For example, a handler override for the `rust_analyzer`:
--
--     ['texlab'] = function()
--
--         require('lspconfig').texlab.setup({
--             capabilities = generate_capabilities(),
--             on_attach = my_on_attach,
--         })
--
--     end
--
-- })
