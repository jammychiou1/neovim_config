-- install node
-- :Copilot setup
-- :Copilot enable

-- disable tab as accept
vim.g.copilot_no_tab_map = true
-- otherwise copilot refuses to work
vim.g.copilot_assume_mapped = true

-- change accept to <C-k>
-- reference: https://www.reddit.com/r/neovim/comments/vibbgs/copilot_config_with_nvimcmp/
vim.keymap.set(
    'i', '<C-k>',
    function()
        local suggestion = vim.fn['copilot#Accept']()
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes(suggestion, true, true, true), 'n')
    end,
    { silent = true }
)
