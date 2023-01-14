-- lsp stuff
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

return {
    {
        'neovim/nvim-lspconfig',
        config = function()
            -- TODO: single language server list

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
        end,
    },
    {
        "glepnir/lspsaga.nvim",
        branch = "main",
        event = "BufRead",
        config = function()
            local keymap = vim.keymap.set
            local saga = require('lspsaga')

            saga.setup({
                lightbulb = {
                    sign = false
                },
                ui = {
                    code_action = "",
                }
            })

            -- Lsp finder find the symbol definition implement reference
            -- if there is no implement it will hide
            -- when you use action in finder like open vsplit then you can
            -- use <C-t> to jump back
            keymap("n", "gh", function() vim.cmd("Lspsaga lsp_finder") end, { desc = "LSP finder" })

            -- Code action
            keymap({ "n", "v" }, "<space>ca", function() vim.cmd("Lspsaga code_action") end, { desc = "Code Action" })

            -- Rename
            keymap("n", "<space>rn", function() vim.cmd("Lspsaga rename") end, { desc = "Rename" })

            -- Peek Definition
            -- you can edit the definition file in this flaotwindow
            -- also support open/vsplit/etc operation check definition_action_keys
            -- support tagstack C-t jump back
            keymap("n", "gd", function() vim.cmd("Lspsaga peek_definition") end, { desc = "Peek Definition" })

            -- Outline
            keymap("n", "<leader>uo", function() vim.cmd("Lspsaga outline") end, { desc = "Toggle Outline" })

            -- Hover Doc
            keymap("n", "K", function() vim.cmd("Lspsaga hover_doc") end, { desc = "Hover Doc" })
        end,
    },
    { -- lsp-based folding
        'kevinhwang91/nvim-ufo',
        event = "BufRead",
        dependencies = { 'kevinhwang91/promise-async' },
        config = function()
            vim.o.foldcolumn = '0'
            vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
            vim.o.foldlevelstart = 99
            vim.o.foldenable = true

            -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
            vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
            vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

            require('ufo').setup()
        end,
    },
    { -- auto install lsp servers
        'williamboman/mason-lspconfig.nvim',
        dependencies = {
            'williamboman/mason.nvim',
            config = true,
        },
        config = function()
            local ml = require('mason-lspconfig')

            ml.setup({
                -- TODO: single language server list
                ensure_installed = servers,
            })
        end,
    },
}
