# NeoVim Config

Inspired by [jdhao/nvim-config](https://github.com/jdhao/nvim-config).

## Features

This project aims to configure NeoVim to become a powerful code editor, with the following features:
- Convenient editing / movement keymaps
- Plugin management with Lazy.nvim
- Fancy UI (lualine, bufferline, nvim-tree) and colorscheme (custom catppuccin flavour based on [Amoled](https://github.com/nullchilly/nvim/blob/nvim/lua/config/catppuccin.lua))
- Fast file finding with telescope.nvim
- LaTeX / Markdown previewer (vimtex, markdown-preview)
- Easy language server installation with mason
- Powerful LSP utilities with lspsaga
- Modern folds with nvim-ufo
- Auto completion with nvim-cmp
- Snippets with luasnip
- Syntatical (based on treesitter) and semantical (based on lsp semantic token) highlighting
- Session management with neovim-session-manager
- ...And more

## Installing

- Install neovim >= 0.9 for semantic tokens
- Clone this repo to `~/.config/nvim/`

## Screenshots

![Screenshot_1](https://user-images.githubusercontent.com/29354697/211557883-554f94b1-4639-4317-a8ae-08f563ce2356.png)
![Screenshot_2](https://user-images.githubusercontent.com/29354697/211557890-2081ceea-1d6d-4657-b932-a800b868721f.png)


## Notes for Myself

### Lua Tips

```lua
vim.api.nvim_err_writeln('test')    -- print error
vim.inspect(obj)
vim.json.encode(obj)                -- object to easy-to-read text
vim.g.xxx = yyy                     -- for let g:xxx = yyy
vim.keymap.set / del(...)           -- define key mapping
```
