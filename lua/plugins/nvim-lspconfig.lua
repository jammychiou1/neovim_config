-- TODO: single language server list
local servers = {
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
}

local my_on_attach = function(client, bufnr)

    local buf_map = function(modes, maps)
        for lhs, rhs in pairs(maps) do
            vim.keymap.set(modes, lhs, rhs, { buffer = bufnr })
        end
    end

    local lsp = vim.lsp

    local caps = client.server_capabilities

    if caps.documentFormattingProvider then
        buf_map('n', {
            ['<space>f'] = lsp.buf.format -- format code
        })
    end

    require('lspsaga')

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
