-- file finding
return {
    {
      -- remember to install ripgrep
        'nvim-telescope/telescope.nvim',
        version = '0.1.*',
        cmd = "Telescope",
        dependencies = {
            "AckslD/nvim-neoclip.lua",
            'jedrzejboczar/possession.nvim',
        },
    },
}
