-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--single-branch",
        "https://github.com/folke/lazy.nvim.git",
        lazypath,
    })
end
vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup({

    -- fancy UI
    -- the colorscheme should be available when starting Neovim
    { -- colorscheme
        'catppuccin/nvim',
        name = 'catppuccin',
        config = function()
            -- ref: https://github.com/nullchilly/nvim/blob/nvim/lua/config/catppuccin.lua
            require('catppuccin').setup({
                flavour = 'mocha', -- latte, frappe, macchiato, mocha
                term_colors = true,
                transparent_background = false,
                no_italic = false,
                no_bold = false,
                styles = {
                    comments = {},
                    conditionals = {},
                    loops = {},
                    functions = {},
                    keywords = {},
                    strings = {},
                    variables = {},
                    numbers = {},
                    booleans = {},
                    properties = {},
                    types = {},
                },
                color_overrides = {
                    mocha = {
                        base = '#000000',
                        mantle = '#101010',
                        crust = '#202020',
                    },
                },
                highlight_overrides = {
                    mocha = function(C)
                        return {
                            NvimTreeNormal = { bg = '#080808' },
                            NvimTreeEndOfBuffer = { bg = '#080808', fg = '#080808' },
                            Pmenu = { bg = C.mantle },
                            LspSagaLightBulb = { fg = C.yellow },
                        }
                    end,
                },
            })
            vim.cmd.colorscheme('catppuccin')
        end
    },
    { -- fancy statusline, remember to install patch fonts https://www.nerdfonts.com/#home
        'nvim-lualine/lualine.nvim',
        dependencies = {
            'catppuccin',
            'kyazdani42/nvim-web-devicons'
        },
        config = function()
            require('lualine').setup({
                extensions = {
                    'nvim-tree'
                }
            })
        end,
    },
    { -- fancy buffer line
        'akinsho/bufferline.nvim',
        dependencies = {
            'catppuccin',
            'kyazdani42/nvim-web-devicons'
        },
        version = 'v3.*',
        config = function()
            -- modified from https://github.com/catppuccin/nvim/blob/main/lua/catppuccin/groups/integrations/bufferline.lua
            local C = require("catppuccin.palettes").get_palette()

            local line_fill = C.mantle

            local tab_bg = C.base
            local tab_bg_inactive = '#040404'

            local separator_fg = C.mantle

            -- local styles = { "bold" }

            local highlights = {
                -- buffers
                background = { bg = tab_bg_inactive },
                -- buffer_visible = { fg = C.surface1, bg = tab_bg },
                buffer_selected = { fg = C.text, bg = tab_bg, bold = true, italic = false }, -- current
                -- Duplicate
                duplicate_selected = { fg = C.text, bg = tab_bg, bold = true, italic = false },
                duplicate_visible = { fg = C.surface1, bg = tab_bg, bold = true, italic = false },
                duplicate = { fg = C.surface1, bg = tab_bg_inactive, bold = true, italic = false },
                -- tabs
                tab = { fg = C.surface1, bg = tab_bg_inactive },
                tab_selected = { fg = C.sky, bg = tab_bg, bold = true, italic = false },
                tab_separator = { fg = separator_fg, bg = tab_bg_inactive },
                tab_separator_selected = { fg = C.maroon, bg = tab_bg },

                tab_close = { fg = C.red, bg = line_fill },
                indicator_selected = { fg = C.peach, bg = tab_bg, bold = true, italic = false },
                -- separators
                separator = { fg = separator_fg, bg = tab_bg_inactive },
                separator_visible = { fg = separator_fg, bg = tab_bg },
                separator_selected = { fg = separator_fg, bg = tab_bg },
                offset_separator = { fg = separator_fg, bg = tab_bg },
                -- close buttons
                close_button = { fg = C.surface1, bg = tab_bg_inactive },
                close_button_visible = { fg = C.surface1, bg = tab_bg },
                close_button_selected = { fg = C.red, bg = tab_bg },
                -- Empty fill
                fill = { bg = line_fill },
                -- Numbers
                numbers = { fg = C.subtext0, bg = tab_bg_inactive },
                numbers_visible = { fg = C.subtext0, bg = tab_bg },
                numbers_selected = { fg = C.subtext0, bg = tab_bg, bold = true, italic = false },
                -- Errors
                error = { fg = C.red, bg = tab_bg_inactive },
                error_visible = { fg = C.red, bg = tab_bg },
                error_selected = { fg = C.red, bg = tab_bg, bold = true, italic = false },
                error_diagnostic = { fg = C.red, bg = tab_bg_inactive },
                error_diagnostic_visible = { fg = C.red, bg = tab_bg },
                error_diagnostic_selected = { fg = C.red, bg = tab_bg },
                -- Warnings
                warning = { fg = C.yellow, bg = tab_bg_inactive },
                warning_visible = { fg = C.yellow, bg = tab_bg },
                warning_selected = { fg = C.yellow, bg = tab_bg, bold = true, italic = false },
                warning_diagnostic = { fg = C.yellow, bg = tab_bg_inactive },
                warning_diagnostic_visible = { fg = C.yellow, bg = tab_bg },
                warning_diagnostic_selected = { fg = C.yellow, bg = tab_bg },
                -- Infos
                info = { fg = C.sky, bg = tab_bg_inactive },
                info_visible = { fg = C.sky, bg = tab_bg },
                info_selected = { fg = C.sky, bg = tab_bg, bold = true, italic = false },
                info_diagnostic = { fg = C.sky, bg = tab_bg_inactive },
                info_diagnostic_visible = { fg = C.sky, bg = tab_bg },
                info_diagnostic_selected = { fg = C.sky, bg = tab_bg },
                -- Hint
                hint = { fg = C.teal, bg = tab_bg_inactive },
                hint_visible = { fg = C.teal, bg = tab_bg },
                hint_selected = { fg = C.teal, bg = tab_bg, bold = true, italic = false },
                hint_diagnostic = { fg = C.teal, bg = tab_bg_inactive },
                hint_diagnostic_visible = { fg = C.teal, bg = tab_bg },
                hint_diagnostic_selected = { fg = C.teal, bg = tab_bg },
                -- Diagnostics
                diagnostic = { fg = C.subtext0, bg = tab_bg_inactive },
                diagnostic_visible = { fg = C.subtext0, bg = tab_bg },
                diagnostic_selected = { fg = C.subtext0, bg = tab_bg, bold = true, italic = false },
                -- Modified
                modified = { fg = C.peach, bg = tab_bg_inactive },
                modified_selected = { fg = C.peach, bg = tab_bg },
            }
            require('bufferline').setup({
                options = {
                    mode = 'tabs',
                    separator_style = 'thick',
                    show_close_icon = false
                },
                highlights = highlights
            })
        end,
    },
    { -- directory viewer
        'nvim-tree/nvim-tree.lua',
        dependencies = {
            'catppuccin',
            'kyazdani42/nvim-web-devicons'
        },
        config = function()
            require('nvim-tree').setup({
                open_on_setup = true,
                open_on_setup_file = true,
                open_on_tab = true,
                view = {
                    -- signcolumn = "no",
                }
            })
        end,
    },
    {
        "startup-nvim/startup.nvim",
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim"
        },
        config = function()
            require "startup".setup({ theme = "dashboard" })
        end
    },
    { -- syntax parsing, remember to install treesitter-cli
        'nvim-treesitter/nvim-treesitter',
        build = function()
            require('nvim-treesitter.install').update({ with_sync = true })
        end,
        config = function()
            require('nvim-treesitter.configs').setup({
                ensure_installed = { "c", "cpp", "make", "cmake", "go", "python", "lua", "bash", "markdown", "latex", "javascript", "html", "verilog" },
                auto_install = true,
            })
        end
    },
    {
        'mrjones2014/nvim-ts-rainbow',
        dependencies = { 'nvim-treesitter' },
        config = function()
            require('nvim-treesitter.configs').setup {
                rainbow = {
                    enable = true,
                }
            }
        end,
    },

    -- editing, movement and text objects
    { -- manipulating parentheses, brackets, quotes, etc.
        'machakann/vim-sandwich',
        init = function()
            vim.g.sandwich_no_default_key_mappings = 1
            vim.g.operator_sandwich_no_default_key_mappings = 1
            vim.g.textobj_sandwich_no_default_key_mappings = 1
        end,
        config = function()
            vim.api.nvim_command 'runtime macros/sandwich/keymap/surround.vim'
        end
    },
    { -- replace with register
        'gbprod/substitute.nvim',
        keys = {
            { "s", function() require('substitute').operator() end, mode = "n", desc = "Substitute" },
            { "ss", function() require('substitute').operator() end, mode = "n", desc = "Substitute" },
            { "S", function() require('substitute').eol() end, mode = "n", desc = "Substitute" },
            { "s", function() require('substitute').visual() end, mode = "x", desc = "Substitute" },
        },
        config = function()
            require('substitute').setup()
        end
    },
    { -- new delete operation
        'svermeulen/vim-cutlass',
        config = function()
            require('plugins.vim-cutlass')
        end,
        -- keys = {
        --     { "x", "d", mode = "n", noremap = true, desc = "Cut" },
        --     { "xx", "dd", mode = "n", noremap = true, desc = "Cut" },
        --     { "X", "D", mode = "n", noremap = true, desc = "Cut" },
        --     { "x", "d", mode = "x", noremap = true, desc = "Cut" },
        -- },
    },
    { -- easy motion
        'phaazon/hop.nvim',
        branch = 'v2', -- optional but strongly recommended
        -- TODO: lazy load
        -- lazy = false,
        config = function()
            require('plugins.hop')
        end
    },
    { -- fast insert mode exit
        'max397574/better-escape.nvim',
        config = function()
            require('better_escape').setup({
                keys = function()
                    return vim.api.nvim_win_get_cursor(0)[2] > 1 and '<esc>l' or '<esc>'
                end,
            })

            -- also exit terminal mode using <C-j><C-j>
            vim.api.nvim_set_keymap('t', '<C-j><C-j>', '<C-\\><C-n>', { noremap = true })
        end,
    },
    {
        'windwp/nvim-autopairs',
        opts = { fast_wrap = {} }
    },
    'wellle/targets.vim',
    -- {
    --     'nvim-treesitter/nvim-treesitter-textobjects',
    --     dependencies = { 'nvim-treesitter' },
    --     config = function()
    --         require('nvim-treesitter.configs').setup {
    --             textobjects = {
    --                 move = {
    --                     enable = true,
    --                     set_jumps = true, -- whether to set jumps in the jumplist
    --                     goto_next_start = {
    --                         [']]'] = { query = '@function.outer', desc = 'Next function start' },
    --                     },
    --                     goto_next_end = {
    --                         [']['] = { query = '@function.outer', desc = 'Next function end' },
    --                     },
    --                     goto_previous_start = {
    --                         ['[['] = { query = '@function.outer', desc = 'Previous function start' },
    --                     },
    --                     goto_previous_end = {
    --                         ['[]'] = { query = '@function.outer', desc = 'Previous function end' },
    --                     },
    --                 },
    --             },
    --         }
    --     end,
    -- }

    -- file finding
    {
        -- remember to install ripgrep
        'nvim-telescope/telescope.nvim',
        tag = '0.1.0',
        dependencies = { 'nvim-lua/plenary.nvim' },
        cmd = "Telescope",
        keys = {
            { "<leader>ff", function() require('telescope.builtin').find_files() end, mode = "n", desc = "Find files" },
            { "<leader>fg", function() require('telescope.builtin').live_grep() end, mode = "n", desc = "Live grep" },
            { "<leader>fb", function() require('telescope.builtin').buffers() end, mode = "n", desc = "Find buffer" },
            { "<leader>fh", function() require('telescope.builtin').help_tags() end, mode = "n", desc = "Find help tags" },
        },
    },

    -- auto completion
    { -- completion engine
        'hrsh7th/nvim-cmp',
        lazy = true,
        dependencies = { 'L3MON4D3/LuaSnip' },
        config = function()
            require('plugins.nvim-cmp')
        end,
    },
    -- completion sources
    {
        'hrsh7th/cmp-nvim-lsp',
        dependencies = { 'nvim-cmp' },
    },
    {
        'hrsh7th/cmp-buffer',
        dependencies = { 'nvim-cmp' },
    },
    {
        'hrsh7th/cmp-path',
        dependencies = { 'nvim-cmp' },
    },
    {
        'hrsh7th/cmp-nvim-lsp-signature-help',
        dependencies = { 'nvim-cmp' },
    },
    {
        'saadparwaiz1/cmp_luasnip',
        dependencies = { 'nvim-cmp' },
    },

    -- lsp stuff
    {
        'neovim/nvim-lspconfig',
        config = function()
            require('plugins.nvim-lspconfig')
        end,
    },
    {
        "glepnir/lspsaga.nvim",
        branch = "main",
        dependencies = { 'nvim-cmp' },
        config = function()
            local keymap = vim.keymap.set
            local saga = require('lspsaga')

            saga.init_lsp_saga({
                code_action_icon = "",
                code_action_lightbulb = {
                    sign = false
                }
            })

            -- Lsp finder find the symbol definition implement reference
            -- if there is no implement it will hide
            -- when you use action in finder like open vsplit then you can
            -- use <C-t> to jump back
            keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })

            -- Code action
            keymap({ "n", "v" }, "<space>ca", "<cmd>Lspsaga code_action<CR>", { silent = true })

            -- Rename
            keymap("n", "<space>rn", "<cmd>Lspsaga rename<CR>", { silent = true })

            -- Peek Definition
            -- you can edit the definition file in this flaotwindow
            -- also support open/vsplit/etc operation check definition_action_keys
            -- support tagstack C-t jump back
            keymap("n", "gd", "<cmd>Lspsaga peek_definition<CR>", { silent = true })

            -- Show line diagnostics
            -- keymap("n", "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true })

            -- Show cursor diagnostics
            keymap("n", "<leader>cd", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { silent = true })

            -- Diagnostic jump can use `<c-o>` to jump back
            -- keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })
            -- keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })

            -- Only jump to error
            -- keymap("n", "[E", function()
            --   require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
            -- end, { silent = true })
            -- keymap("n", "]E", function()
            --   require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
            -- end, { silent = true })

            -- Outline
            keymap("n", "<leader>o", "<cmd>Lspsaga outline<CR>", { silent = true })

            -- Hover Doc
            keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })

            -- -- Float terminal
            -- keymap("n", "<A-d>", "<cmd>Lspsaga open_floaterm<CR>", { silent = true })

            -- -- Close float terminal
            -- keymap("t", "<A-d>", [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]], { silent = true })
        end,
    },
    { -- auto install lsp & other servers
        'williamboman/mason.nvim',
        lazy = true,
        config = function()
            require('mason').setup()
        end,
    },
    { -- auto config lsp servers
        'williamboman/mason-lspconfig.nvim',
        dependencies = { 'mason.nvim' },
        config = function()
            require('plugins.mason-lspconfig')
        end,
    },

    -- latex stuff
    {
        'lervag/vimtex',
        ft = 'tex',
        config = function()
            -- vim.opt.conceallevel = 2
        end,
    },

    -- markdown stuff
    {
        'iamcco/markdown-preview.nvim',
        ft = 'markdown',
        build = function()
            vim.fn['mkdp#util#install']()
        end,
    },

    -- other
    { -- lsp folding
        'kevinhwang91/nvim-ufo',
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
    { -- switch to English when leaving insert mode
        'lilydjwg/fcitx.vim',
        config = function()
            vim.g.fcitx5_remote = 'fcitx5-remote'
        end,
        ft = { 'tex', 'markdown' },
    },
    'matveyt/vim-opera', -- range commands apply to part of line
    'jdhao/whitespace.nvim', -- show and remove trailing whitespaces
    { -- session manager
        'Shatur/neovim-session-manager',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function() 
            require('session_manager').setup {
                autoload_mode = require('session_manager.config').AutoloadMode.Disabled
            }
        end,
    },
    { -- macro manager
        'svermeulen/vim-macrobatics',
        dependencies = { 'tpope/vim-repeat' },
        config = function()
            vim.g.Mac_NamedMacrosDirectory = '~/.config/nvim/macrobatics'

            vim.keymap.set('n', 'q', '<plug>(Mac_Play)', { nowait = true })
            vim.keymap.set('n', 'gq', '<plug>(Mac_RecordNew)', { nowait = true })

            vim.keymap.set('n', '<leader>mh', function() vim.cmd('DisplayMacroHistory') end)

            vim.keymap.set('n', '[m', '<plug>(Mac_RotateBack)')
            vim.keymap.set('n', ']m', '<plug>(Mac_RotateForward)')
        end,
    },
    { -- show keymap
        'folke/which-key.nvim',
        config = function()
            require('which-key').setup()
        end
    },
    { -- scroll animation
        'karb94/neoscroll.nvim',
        config = function()
            require('neoscroll').setup()
        end
    },
})
