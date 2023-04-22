-- lsp stuff
local servers = {
    -- 'clangd',
    -- no language server for make yet
    -- 'cmake',
    -- 'gopls',
    -- 'pyright',
    -- 'lua_ls',
    -- 'bashls',
    -- 'marksman',
    -- 'texlab',
    -- 'tsserver',
    -- 'html',
    -- 'svlangserver',
}

return {
    { -- auto install lsp servers
        'williamboman/mason-lspconfig.nvim',
        event = "VeryLazy",
        dependencies = {
            { 'williamboman/mason.nvim', config = true },
        },
        config = function()
            local ml = require('mason-lspconfig')

            ml.setup({
                ensure_installed = servers,
            })
        end,
    },
    {
        'neovim/nvim-lspconfig',
        event = "VeryLazy",
        dependencies = {
            'williamboman/mason-lspconfig.nvim',
            {
                'tamago324/nlsp-settings.nvim',
                config = function()
                    require("nlspsettings").setup({})
                end,
            },
        },
        config = function()
            local lspconfig = require("lspconfig")

            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            capabilities.textDocument.foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true
            }

            lspconfig.util.default_config = vim.tbl_extend("force", lspconfig.util.default_config, {
              capabilities = capabilities,
            })

            for _, server_name in pairs(servers) do
                -- local settings = {}
                -- if server_name == 'texlab' then
                --     settings = {
                --         texlab = {
                --             latexindent = {
                --                 -- latexindent config is complicated
                --                 -- vim.fn.expand does not recognize '${HOME}'
                --                 ['local'] = vim.fn.stdpath("config") .. "/indentSetting.yaml"
                --             },
                --         },
                --     }
                -- end
                require('lspconfig')[server_name].setup({
                    -- capabilities = generate_capabilities(),
                    -- settings = settings,
                })
            end
        end,
    },
    {
        'mrded/nvim-lsp-notify',
        enabled = false,
        event = "BufRead",
        config = function()
            require('lsp-notify').setup({})
        end
    },
    {
        "glepnir/lspsaga.nvim",
        cmd = "Lspsaga",
        event = "BufRead",
        dependencies = {
            -- {"nvim-tree/nvim-web-devicons"},
            --Please make sure you install markdown and markdown_inline parser
            -- {"nvim-treesitter/nvim-treesitter"},
            { 'neovim/nvim-lspconfig' },
        },
        config = function()
            local C = require("catppuccin.palettes").get_palette()
            require('lspsaga').setup({
                lightbulb = {
                    sign = false
                },
                ui = {
                    code_action = "",
                    diagnostic = "",
                    colors = {
                        --float window normal background color
                        normal_bg = C.mantle,
                        --title background color
                        title_bg = '#afd700',
                    },
                },
            })
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

            require('ufo').setup()
        end,
    },
    {
        'jose-elias-alvarez/null-ls.nvim',
        event = "BufRead",
        config = function()
            local null_ls = require("null-ls")

            null_ls.setup({
                sources = {
                    -- null_ls.builtins.completion.spell,
                },
            })
        end
    },
    {
        "ThePrimeagen/refactoring.nvim",
        lazy = true,
        config = function()
            require('refactoring').setup({})
        end
    },
}
