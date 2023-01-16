-- syntax highlighting
return {
    { -- syntax parsing, remember to install treesitter-cli
        'nvim-treesitter/nvim-treesitter',
        build = function()
            require('nvim-treesitter.install').update({ with_sync = true })
        end,
        config = function()
            require('nvim-treesitter.configs').setup({
                ensure_installed = {
                    "c", "cpp", "make", "cmake", "go", "python", "lua", "bash", "markdown", "latex",
                    "javascript", "html", "verilog"
                },
                incremental_selection = {
                    enable = true,
                    -- TODO: better keymaps
                    keymaps = {
                        init_selection = "<CR>", -- set to `false` to disable one of the mappings
                        node_incremental = "<CR>",
                        scope_incremental = false,
                        node_decremental = "<S-CR>",
                    },
                },
            })
        end
    },
    { -- rainbow parentheses
        'mrjones2014/nvim-ts-rainbow',
        event = "BufRead",
        config = function()
            require('nvim-treesitter.configs').setup {
                rainbow = {
                    enable = true,
                }
            }
        end,
    },
}
