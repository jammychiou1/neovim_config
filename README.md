Inspired by [jdhao/nvim-config](https://github.com/jdhao/nvim-config)

## steps

install neovim > 0.8

download packer.nvim to `~/.local/share/nvim/site/pack/packer/start/`

run `:PackerInstall`

## lua tips

```lua
vim.api.nvim_err_writeln('test') -- print error
vim.inspect(obj)
vim.json.encode(obj)
vim.g.xxx = yyy         -- for let g:xxx = yyy
vim.keymap              -- define mapping
```
