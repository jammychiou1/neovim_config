-- remember to run PackerCompile after modifying this file
require('packer').startup(function(use)

    -- packer manages itself
    use 'wbthomason/packer.nvim'

    -- editing, movement and text objects
    use 'machakann/vim-sandwich'            -- manipulating parentheses, brackets, quotes, etc.
    use 'vim-scripts/ReplaceWithRegister'   -- replace text object with register
    use {                                   -- new delete operation
        'svermeulen/vim-cutlass',
        config = function()
            require('plugins.vim-cutlass')
        end,
    }
    use 'vim-scripts/argtextobj.vim'        -- text objects for arguments
    use {                                   -- easy motion
        'phaazon/hop.nvim',
        branch = 'v2',                      -- optional but strongly recommended
        config = function()
            require('plugins.hop')
        end
    }

    -- auto completion
    use {
        'hrsh7th/nvim-cmp',
        config = function()
            require('plugins.nvim-cmp')
        end,
    }
    use { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' }
    use { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' }
    use { 'hrsh7th/cmp-path', after = 'nvim-cmp' }

    -- lsp stuff
    use {                                       -- auto install lsp & other servers
        'williamboman/mason.nvim',
        config = function()
            require('mason').setup()
        end,
    }
    use {
        'williamboman/mason-lspconfig.nvim',    -- auto config lsp servers
        config = function()
            require('plugins.mason-lspconfig')
        end,
        after = {
            'mason.nvim',
            'nvim-lspconfig',
        },
    }
    use {
        'neovim/nvim-lspconfig',
        config = function()
            require('plugins.nvim-lspconfig')
        end,
        after = 'cmp-nvim-lsp',
    }

    -- latex stuff
    use {
        'lervag/vimtex',
        ft = 'tex',
    }

    -- markdown stuff
    use {
        'iamcco/markdown-preview.nvim',
        ft = 'markdown',
        run = function()
            vim.fn['mkdp#util#install']()
        end,
    }

    -- fancy visuals
    use 'kyazdani42/nvim-web-devicons'      -- icons
    use {                                   -- colorscheme
        'catppuccin/nvim',
        as = 'catppuccin',
        config = function()
            require('catppuccin').setup {
                flavour = 'macchiato',
                integrations = {
                    semantic_tokens = true,
                },
            }
            vim.api.nvim_command 'colorscheme catppuccin'
        end
    }
    use {                                   -- fancy statusline, remember to install patch fonts https://www.nerdfonts.com/#home
        'nvim-lualine/lualine.nvim',
        config = function()
            require('lualine').setup({
                options = {
                    theme = 'catppuccin',
                },
            })
        end,
    }
    use {                                   -- fancy buffer line
        'akinsho/bufferline.nvim',
        tag = 'v3.*',
        config = function()
            require('bufferline').setup({
                highlights = require("catppuccin.groups.integrations.bufferline").get()
            })
        end,
    }
    use {
        'nvim-tree/nvim-tree.lua',
        config = function()
            require('nvim-tree').setup({
                open_on_setup = true,
                open_on_setup_file = true,
            })
        end,
    }
    use {                                   -- cfg syntax parsing
        'nvim-treesitter/nvim-treesitter',
        run = function()
            require('nvim-treesitter.install').update({ with_sync = true })
        end,
        config = function()
            require'nvim-treesitter.configs'.setup {
                highlight = {
                    enable = false
                },
            }
        end,
    }
    use {
        'theHamsta/nvim-semantic-tokens',   -- semantic highlighting
        after = 'nvim-treesitter',
        -- reference: https://alpha2phi.medium.com/neovim-semantic-highlighting-6c702bd816cf
        config = function()
            -- local set_hl = vim.api.nvim_set_hl
            -- -- token
            -- -- https://github.com/nvim-treesitter/nvim-treesitter/blob/master/lua/nvim-treesitter/highlight.lua
            -- set_hl(0, "LspParameter", { link = "TSParameter" })
            -- set_hl(0, "LspType", { link = "TSType" })
            -- set_hl(0, "LspClass", { link = "TSStorageClass" })
            -- set_hl(0, "LspComment", { link = "TSComment" })
            -- set_hl(0, "LspDecorator", { link = "TSAnnotation" })
            -- set_hl(0, "LspEnum", { link = "TSType" })
            -- set_hl(0, "LspEnumMember", { link = "TSParameter" })
            -- set_hl(0, "LspEvent", { link = "TSProperty" })
            -- set_hl(0, "LspFunction", { link = "TSFunction" })
            -- set_hl(0, "LspInterface", { link = "TSKeywordFunction" })
            -- set_hl(0, "LspKeyword", { link = "TSKeyword" })
            -- set_hl(0, "LspMacro", { link = "TSFuncMacro" })
            -- set_hl(0, "LspMethod", { link = "TSMethod" })
            -- set_hl(0, "LspModifier", { link = "TSTypeQualifier" })
            -- set_hl(0, "LspNamespace", { link = "TSNamespace" })
            -- set_hl(0, "LspNumber", { link = "TSNumber" })
            -- set_hl(0, "LspOperator", { link = "TSOperator" })
            -- set_hl(0, "LspProperty", { link = "TSProperty" })
            -- set_hl(0, "LspRegexp", { link = "TSStringRegex" })
            -- set_hl(0, "LspString", { link = "TSString" })
            -- set_hl(0, "LspStruct", { link = "TSTypeDefinition" })
            -- set_hl(0, "LspTypeParameter", { link = "TSType" })
            -- set_hl(0, "LspVariable", { link = "TSVariable" })

            -- -- modifier
            -- set_hl(0, "LspDeclaration", { link = "TSDefine" })
            -- set_hl(0, "LspDefinition", { link = "TSTypeDefinition" })
            -- set_hl(0, "LspReadonly", { link = "TSContant" })
            -- set_hl(0, "LspStatic", { link = "TSConsantMacro" })
            -- set_hl(0, "LspDeprecated", { link = "TSWarning" })
            -- set_hl(0, "LspAbstract", { fg = "#9E6162" })
            -- set_hl(0, "LspAsync", { fg = "#81A35C" })
            -- set_hl(0, "LspModification", { fg = "#7E5CA3" })
            -- set_hl(0, "LspDocumentation", { fg = "#ccc0f5" })
            -- set_hl(0, "LspDefaultLibrary", { fg = "#c99dc1" })

            require("nvim-semantic-tokens").setup {
                preset = "default",
                -- highlighters is a list of modules following the interface of nvim-semantic-tokens.table-highlighter or
                -- function with the signature: highlight_token(ctx, token, highlight) where
                --        ctx (as defined in :h lsp-handler)
                --        token  (as defined in :h vim.lsp.semantic_tokens.on_full())
                --        highlight (a helper function that you can call (also multiple times) with the determined highlight group(s) as the only parameter)
                highlighters = { require 'nvim-semantic-tokens.table-highlighter'}
            }
        end,
    }

    -- other
    use {
        'github/copilot.vim',
        config = function()
            require('plugins.copilot')
        end,
    }
    use {                                   -- switch to English when leaving insert mode
        'lilydjwg/fcitx.vim',
        setup = function()
            vim.g.fcitx5_remote = 'fcitx5-remote'
        end,
        ft = { 'tex', 'markdown' },
    }
    use 'matveyt/vim-opera'                 -- range commands apply to part of line
    use {                                   -- show and remove trailing whitespaces
        'jdhao/whitespace.nvim',
        event = 'VimEnter',
    }
end)
