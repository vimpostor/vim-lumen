# vim-lumen

This plugin enables vim to follow the global system-wide dark mode preference of your platform.

https://user-images.githubusercontent.com/21310755/164289278-6368d615-e363-4185-a7c1-0f79ae3bf7b1.mov

At the moment, the only supported platform is Linux, but PRs are highly welcome to add support for other platforms.

# Installation

With `vim-plug` add the following line to your `.vimrc`:

```vim
Plug 'vimpostor/vim-lumen'
```

# Dependencies

On Linux it is required that you have `gdbus` installed together with **one** of the following options:

- KDE Plasma 5.24 (or later) or
- Gnome 42 (or later) or
- [third-party color-scheme-simulator](https://gitlab.gnome.org/exalm/color-scheme-simulator) or
- [darkman](https://gitlab.com/WhyNotHugo/darkman)

Once a system dark mode preference change is detected, this plugin will set the `background` vim option accordingly, so make sure that your colorscheme supports reloading as described in `:h 'background'`.

# FAQ

## Why not use the brand new SIGWINCH autocmd in neovim?

Neovim recently merged [support for SIGWINCH autocmds](https://github.com/neovim/neovim/pull/18029). It is possible to hack together dark mode support by abusing the `SIGWINCH` autocmd, but this has quite a few disadvantages:

- You require a terminal that sends `SIGWINCH` when the system-wide dark mode preference changes. At the moment, pretty much no terminal supports this besides `iTerm`.
- The `SIGWINCH` event is fired regularly for other events. For example while resizing the window, `SIGWINCH` can be emitted many times per second, which causes performance issues due to checking the system dark mode preference multiple times per second.
- This plugin is interrupted immediately after the system-wide dark mode preference changes thus eliminating the need to manually look up the dark mode preference.
- `SIGWINCH` is not really intended for this usecase at all. You are abusing a signal that is originally only meant to be fired when the terminal size changes.
- There is only `SIGWINCH` support in `neovim`, whereas this plugin also supports regular vim.

## How can I make this plugin follow the dark mode preference on startup already?

By default vim already tries to guess the correct value for `background` on startup. Therefore by default this plugin does not get in the way of vim's internal detection mechanism and is only responsible for changes during runtime.
If you'd also like this plugin to detect the system-wide dark mode preference of your platform on startup, use:

```vim
let g:lumen_startup_overwrite = 1
```
