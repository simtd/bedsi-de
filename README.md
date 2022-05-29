# Bedsi - My [Arch](https://archlinux.org/) Dotfiles

A complete desktop environment using the [dwm](https://dwm.suckless.org/) window manager.

<img src="https://github.com/simtd/bedsi-de/blob/main/Pictures/screen.png" alt="screenshot">
(screenshot may be outdated)

## Highlights

* [Z shell configuration](https://github.com/simtd/bedsi-de/blob/main/.config/zsh/.zshrc)
* Source code for my [patched dwm](https://github.com/simtd/bedsi-de/tree/main/.local/src/suckless/dwm)
* Scripts for pulseaudio to [change volume](https://github.com/simtd/bedsi-de/blob/main/.local/bin/volume-control)
* [dmenu scripts](https://github.com/simtd/bedsi-de/tree/main/.local/bin/dmenu)
* [Configuration files](https://github.com/simtd/bedsi-de/tree/main/.config) for various programs

## Installation

- **Note:** at multiple times througout the install process you may need to restart or log in and out for changes to take effect.

### Managing files with git (see: https://www.atlassian.com/git/tutorials/dotfiles)

1) `echo .bedsi-de >> .gitignore`

2) `git clone --bare https://github.com/simtd/bedsi-de.git $HOME/.bedsi-de`

3) `git --git-dir=$HOME/.bedsi-de/ --work-tree=$HOME checkout` (fails if a file exists already)

4) `bed config --local status.showUntrackedFiles no` (bed is an alias for the [bedside script](https://github.com/simtd/bedsi-de/blob/main/.local/bin/bedside) which is just a git wrapper)


### My setup

- Install [paru](https://github.com/morganamilo/paru) AUR helper.
- [Change shell](https://linuxhandbook.com/change-shell-linux/) to zsh.
- Dependencies from [pacman](https://archlinux.org/packages/) and the [aur](https://aur.archlinux.org/) can be listed using `bed pac` and `bed aur` respectively. Install all these.
- Install [gold-bar](https://github.com/simtd/gold-bar) and [dmenu-editor-history](https://github.com/simtd/dmenu-editor-history).
- Replace `sudo` with `doas`.
- Install dwm, slock, st, and dmenu inside `.local/src/suckless` using `doas make clean install` in each of their directories.
- On each login launch the graphical environment with `startx`.
