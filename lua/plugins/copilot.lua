-- install node
-- :Copilot setup
-- :Copilot enable

-- change accept to <C-k>
vim.g.copilot_no_tab_map = true
vim.keymap.set('i', '<C-k>', 'copilot#Accept()', { expr = true, script = true })
