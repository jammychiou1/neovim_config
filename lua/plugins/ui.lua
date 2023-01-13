-- UI plugins
return {
    'kyazdani42/nvim-web-devicons', -- nerd font icons
    'nvim-lua/plenary.nvim', -- helper plugin required by many UI plugins

    { -- startup page
        "startup-nvim/startup.nvim",
        config = function()
            local settings = require('startup.themes.dashboard')
            settings.body.content = {
                { " Find File", "Telescope find_files", "1" },
                { " Find Word", "Telescope live_grep", "2" },
                { " Recent Files", "Telescope oldfiles", "3" },
                { " New File", "lua require'startup'.new_file()", "4" },
                { " Load Session", "SessionManager load_session", "5" },
            }

            require("startup").setup(settings)
        end
    },
    { -- fancy statusline
        'nvim-lualine/lualine.nvim',
        config = function()
            local outline_extension = {
                sections = {
                    lualine_x = {
                        function() return 'Outline' end
                    }
                },
                filetypes = { 'lspsagaoutline' }
            }
            require('lualine').setup({
                extensions = {
                    'nvim-tree',
                    'toggleterm',
                    outline_extension,
                }
            })
        end,
    },
    { -- fancy tab line
        'akinsho/bufferline.nvim',
        version = 'v3.*',
        config = function()
            -- modified from https://github.com/catppuccin/nvim/blob/main/lua/catppuccin/groups/integrations/bufferline.lua
            local C = require("catppuccin.palettes").get_palette()

            local line_fill = C.mantle

            local tab_bg = C.base
            local tab_bg_inactive = C.base

            local separator_fg = C.mantle

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
    { -- indent guide
        "lukas-reineke/indent-blankline.nvim",
        event = "VeryLazy",
    },
    { -- show and remove trailing whitespaces
        'jdhao/whitespace.nvim',
        event = "VeryLazy",
    },
    { -- fancy prompts for input/selection
        'stevearc/dressing.nvim',
        event = "VeryLazy",
    },
    { -- fancy notifications
        'rcarriga/nvim-notify',
        event = "VeryLazy",
        config = function()
            vim.notify = require("notify")
        end,
    },
    { -- directory viewer
        'nvim-tree/nvim-tree.lua',
        init = function()
            -- disable netrw at the very start of your init.lua (strongly advised)
            -- reference: https://github.com/nvim-tree/nvim-tree.lua
            vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1
        end,
        -- cmd = "",
        config = function()
            require('nvim-tree').setup()

            local keymap = vim.keymap.set
            local api = require("nvim-tree.api")

            keymap("n", "<leader>ut", api.tree.toggle, { desc = 'Toggle Nvim Tree' })
        end,
    },
    { -- show keymap
        'folke/which-key.nvim',
        -- TODO: centralized mappings
        -- lazy = true,
        config = function()
            require('which-key').setup()
        end
    },
    { -- scroll animation
        'karb94/neoscroll.nvim',
        -- TODO: centralized mappings
        -- lazy = true,
        config = function()
            require('neoscroll').setup()
        end
    },
    { -- persistent terminals
        "akinsho/toggleterm.nvim",
        version = '2.*',
        cmd = "ToggleTerm",
        config = function()
            require("toggleterm").setup({
                shade_terminals = false
            })
            vim.keymap.set("n", "<leader>tt", function() vim.cmd("ToggleTerm direction=tab") end,
                { desc = "Toggle term in new tab" })
            vim.keymap.set("n", "<leader>tv", function() vim.cmd("ToggleTerm direction=vertical size=40") end,
                { desc = "Toggle term in vertical split" })
            vim.keymap.set("n", "<leader>tf", function() vim.cmd("ToggleTerm direction=float") end,
                { desc = "Toggle term in floating window" })
        end
    },
    { -- session manager
        'Shatur/neovim-session-manager',
        -- cmd = "SessionManager",
        config = function()
            require('session_manager').setup {
                autoload_mode = require('session_manager.config').AutoloadMode.Disabled
            }
            vim.keymap.set('n', '<leader>ss', function() vim.cmd("SessionManager load_session") end,
                { desc = "Load Session" })
        end,
    },
}
