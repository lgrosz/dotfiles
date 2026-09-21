# nvim-lua-next

Neovim config, rewritten for Neovim 0.12 against the built-ins -- `vim.pack`,
`vim.lsp.enable()`, `'autocomplete'`, treesitter -- instead of a plugin manager.

```sh
$ stow -t ~ --dotfiles nvim-lua-next
```

## Conventions

### Options: `vim.o` by default, `vim.opt` only for lists and maps

`:h lua-options` leads with `vim.o` -- "Vim options can be accessed through
`vim.o`, which behaves like Vimscript `:set`" -- and introduces `vim.opt` as "a
special interface [...] for conveniently interacting with list- and map-style
options".

So reach for the `vim.o` family by default, and use `vim.opt` only where the
table syntax or `:append`/`:prepend`/`:remove` actually buys something.

| scope           | use                                      |
| --------------- | ---------------------------------------- |
| global          | `vim.o` (`:set`), `vim.go` (`:setglobal`) |
| buffer-local    | `vim.bo`                                 |
| window-local    | `vim.wo[0][0]` (`:setlocal`)             |

```lua
vim.o.ignorecase = true                       -- scalar: vim.o
vim.bo.indentexpr = '...'                     -- buffer-local
vim.wo[0][0].spell = true                     -- window-local
vim.opt.completeopt = { 'menu', 'popup' }     -- list: vim.opt earns its keep
vim.opt_local.iskeyword:append({ '-', '.' })  -- :append: likewise
```

Prefer `vim.wo[0][0]` over a bare `vim.wo`. For a window-local option a bare
`vim.wo` behaves like `:set`, not `:setlocal` (`:h vim.wo`), so it also writes
the global value and the setting leaks into buffers opened later in that
window.

### Keymaps: call Lua with a function, not a `<Cmd>lua ...<CR>` string

`:h lua-guide-mappings` takes a Lua function as the `{rhs}`, and wrapping the
`require` in `function() end` defers loading the plugin "to the time when the
mapping is executed":

```lua
vim.keymap.set('n', '<leader>sf', function() require('fzf-lua').files() end,
  { desc = '[S]earch [F]iles' })
```

Not `'<Cmd>lua require("fzf-lua").files()<CR>'`: the string defers just the
same, but it hides the call inside a string where nothing can check it, and it
forces a second set of quotes. A bare `require('fzf-lua').files` would load the
plugin when the mapping is *defined*, which defeats the point.

Every mapping gets a `desc`.
