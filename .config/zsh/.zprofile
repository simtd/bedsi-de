#############################
### ENVIRONMENT VARIABLES ###
#############################

# default programs
export EDITOR="nvim"
export TERMINAL="alacritty"
export BROWSER="brave"

# adding ~/.local/bin to path
export PATH="$PATH:$(du "$HOME/.local/bin" | cut -f2 | paste -sd ':')"

# for statusbar
export STATUS_PIPE="/tmp/statusbar-fifo"

# theme file that is imported in multiple scripts
export THEME="$HOME/.local/share/theme"

# golang
export GOPATH="$HOME/Coding/go"
export PATH="${PATH:+${PATH}:}$GOPATH/bin"

# coloring manpages
export LESS_TERMCAP_md=$'\e[01;31m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;40;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[01;32m'

# making fzf use terminal colors
export FZF_DEFAULT_OPTS='--color 16'

# cleaning up ~
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XAUTHORITY="$HOME/.config/X11/Xauthority"
export XRESOURCES="$HOME/.config/X11/Xresources"
export ZDOTDIR="$HOME/.config/zsh"
export PYLINTHOME="$HOME/.cache"
export LESSHISTFILE="$HOME/.cache/lesshst"
export GNUPGHOME="$HOME/.local/share/gnupg"