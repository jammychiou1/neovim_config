-- syntax highlighting
return {
    { -- syntax parsing, remember to install treesitter-cli
        'nvim-treesitter/nvim-treesitter',
        build = function()
            require('nvim-treesitter.install').update({ with_sync = true })
        end,
        event = "VeryLazy",
        config = function()
            require('nvim-treesitter.configs').setup({
                ensure_installed = {
                    -- "c", "cpp", "make", "cmake", "go", "python", "lua", "bash",
                    -- "markdown", "markdown_inline",
                    -- "latex", "javascript", "html", "verilog"
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
