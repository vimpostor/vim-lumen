# vim-lumen

This plugin enables vim to follow the global system-wide dark mode preference of your platform.

https://user-images.githubusercontent.com/21310755/225781457-2a1e4f26-fbd5-4c08-a75e-2c2f931488b3.mp4

At the moment, supported platforms are **Linux** and **MacOS**, but PRs are highly welcome to add support for other platforms.

# Installation

With `vim-plug` add the following line to your `.vimrc`:

```vim
Plug 'vimpostor/vim-lumen'
```

Once a system dark mode preference change is detected, this plugin will set the `background` vim option accordingly, so make sure that your colorscheme supports reloading as described in `:h 'background'`.

# Dependencies

## Linux

On Linux it is required that you have `gdbus` installed together with **one** of the following options:

- KDE Plasma 5.24 (or later) or
- Gnome 42 (or later) or
- [darkman](https://gitlab.com/WhyNotHugo/darkman) (Recommended for tiling WMs) or
- [color-scheme-simulator](https://gitlab.gnome.org/exalm/color-scheme-simulator)

Make sure that the `xdg-desktop-portal` is running.

## MacOS

It is required that Swift is available on your system. Swift is shipped with Xcode for example.

# FAQ

## How can I add custom callbacks?

You can use the `LumenLight` and `LumenDark` `User` autocommands:
```vim
au User LumenLight echom 'Entered light mode'
au User LumenDark echom 'Entered dark mode'
```

## Why not use the new SIGWINCH autocmd in neovim?

Neovim recently merged [support for SIGWINCH autocmds](https://github.com/neovim/neovim/pull/18029). It is possible to hack together dark mode support by abusing the `SIGWINCH` autocmd, but this has quite a few disadvantages:

- You require a terminal that sends `SIGWINCH` when the system-wide dark mode preference changes. At the moment, pretty much no terminal supports this besides `iTerm`
- The `SIGWINCH` event is fired regularly for other events. For example while resizing the window, `SIGWINCH` can be emitted many times per second, which causes performance issues due to checking the system dark mode preference multiple times per second
- This plugin is interrupted immediately after the system-wide dark mode preference changes thus eliminating the need to manually look up the dark mode preference
- `SIGWINCH` is not really intended for this usecase at all. You are abusing a signal that is originally only meant to be fired when the terminal size changes
- There is only `SIGWINCH` support in `neovim`, whereas this plugin also supports regular vim
