-- TODO: make this a standalone plugin
local M = {}

function M.setup(opts)
    local default_opts = {
        default_clip_reg = '+',
        default_macro_reg = 'm',
        count = 2,
        mapping = {
            save_clip = { '<M-W>', '<M-E>' },
            save_macro = { '<leader>mw', '<leader>me' },
            load_both = { '<M-w>', '<M-e>' },
        }
    }

    M.opts = setmetatable(opts or {}, { __index = default_opts })

    M.alt_clip = {}
    M.alt_macro = {}

    for i = 1, M.opts.count do
        M.alt_clip[i] = ''
        M.alt_macro[i] = ''
    end

    local function save_alt_clip(i)
        M.alt_clip[i] = vim.fn.getreg(M.opts.default_clip_reg)
    end

    local function save_alt_macro(i)
        M.alt_macro[i] = vim.fn.getreg(M.opts.default_macro_reg)
    end

    local function load_alt(i)
        vim.fn.setreg(M.opts.default_clip_reg, M.alt_clip[i])
        vim.fn.setreg(M.opts.default_macro_reg, M.alt_macro[i])
    end

    local set = vim.keymap.set

    for i = 1, M.opts.count do
        set('n', M.opts.mapping.save_clip[i], function() save_alt_clip(i) end)
        set('n', M.opts.mapping.save_macro[i], function() save_alt_macro(i) end)
        set({ 'n', 'x', 'i' }, M.opts.mapping.load_both[i], function() load_alt(i) end)
    end
end

return M
