# Neovim

## Environment-specific colorschemes

Keep host-specific appearance in `init.local.lua`, not in the shared plugin
configuration. This file lives beside `init.lua`, is gitignored, and can return
an `after_init` function that runs after the shared configuration has loaded.
Without a local override, the shared configuration uses Catppuccin Mocha.

Neovim can identify its terminal host through `vim.env.TERM_PROGRAM`. For example,
Orca sets this variable to `Orca`. Check it in the terminal where you launch Neovim:

```sh
echo "$TERM_PROGRAM"
```

This identifies the host application, not its selected theme. The configuration
below explicitly chooses dark Gruvbox in Orca and leaves other hosts unchanged.

### Example: dark Gruvbox in Orca

Install [gruvbox.nvim](https://github.com/ellisonleao/gruvbox.nvim) locally as an
optional native package. This example uses release `2.0.0` and the default Neovim
data directory on macOS/Linux:

```sh
git clone --depth 1 --branch 2.0.0 \
  https://github.com/ellisonleao/gruvbox.nvim.git \
  "${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/pack/local/opt/gruvbox.nvim"
```

Skip the clone if the package is already installed there. Keeping it outside the
configuration repository avoids adding a machine-specific dependency to the
shared plugin list or `nvim-pack-lock.json`.

Create `init.local.lua` beside `init.lua` (normally `~/.config/nvim/init.local.lua`):

```lua
return {
  after_init = function()
    if vim.env.TERM_PROGRAM ~= "Orca" then
      return
    end

    vim.cmd.packadd "gruvbox.nvim"
    vim.o.background = "dark"
    vim.cmd.colorscheme "gruvbox"
  end,
}
```

If you already have local customizations, merge this logic into the existing
`after_init` function instead of replacing the file. Restart Neovim to apply it.
Check the selected colorscheme with `:colorscheme` and the background mode with
`:set background?`.

### Other environments

Use additional explicit host checks for other terminal applications. Inspect
`TERM_PROGRAM` in each host rather than assuming its value. If a host does not
provide a reliable identifier, set a custom environment variable in its shell
startup configuration and read it through `vim.env`.

The host-specific branch above loads Gruvbox only inside Orca. Other terminals
retain the shared colorscheme. It does not track subsequent changes to the host's
own theme.

Tmux and SSH can preserve, replace, or omit environment variables. Check
`TERM_PROGRAM` inside the actual session where Neovim runs; do not assume it
identifies the outer terminal. No tmux or SSH forwarding is configured by this
example.
