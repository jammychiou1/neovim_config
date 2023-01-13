-- file finding
return {
    { -- remember to install ripgrep
        'nvim-telescope/telescope.nvim',
        version = '0.1.*',
        dependencies = { 'nvim-lua/plenary.nvim' },
        cmd = "Telescope",
        keys = {
            { "<leader>ff", function() require('telescope.builtin').find_files() end, mode = "n", desc = "Find files" },
            { "<leader>fg", function() require('telescope.builtin').live_grep() end, mode = "n", desc = "Live grep" },
            { "<leader>fb", function() require('telescope.builtin').buffers() end, mode = "n", desc = "Find buffer" },
            { "<leader>fh", function() require('telescope.builtin').help_tags() end, mode = "n", desc = "Find help tags" },
        },
    },
}
