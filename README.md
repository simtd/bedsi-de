# Bedsi - My [Arch](https://archlinux.org/) Dotfiles

A complete desktop environment using the [dwm](https://dwm.suckless.org/) window manager.

## Highlights

* Simple modular statusbar script [rnstatus](https://github.com/simtd/bedsi-de/blob/main/.local/bin/statusbar) for dwm with event-driven signal handling
* [Z shell configuration](https://github.com/simtd/bedsi-de/blob/main/.config/zsh/.zshrc)
* Source code for my [patched dwm](https://github.com/simtd/bedsi-de/tree/main/.local/src/suckless/dwm)
* Scripts for pulseaudio to [change volume](https://github.com/simtd/bedsi-de/blob/main/.local/bin/volume-control)
* [dmenu scripts](https://github.com/simtd/bedsi-de/tree/main/.local/bin/dmenu)
* [Configuration files](https://github.com/simtd/bedsi-de/tree/main/.config) for various programs

## Installation

Lifted from: https://www.atlassian.com/git/tutorials/dotfiles

1) `echo .bedsi-de >> .gitignore`

2) `git clone --bare https://github.com/simtd/bedsi-de.git $HOME/.bedsi-de`

3) `git --git-dir=$HOME/.bedsi-de/ --work-tree=$HOME checkout` (fails if a file exists already)

4) `bed config --local status.showUntrackedFiles no` (bed is an alias for the [bedside script](https://github.com/simtd/bedsi-de/blob/main/.local/bin/bedside) which is just a git wrapper)
