############
## PROMPT ##
############

function set-prompt() {
    local branch="$(git rev-parse --abbrev-ref HEAD 2>/dev/null)"
    [[ -z $branch ]] || branch=" %F{6}${branch//\%/%%}%f"
    PROMPT="%B%(?.%F{5}%#%f.%F{1}%?%f %F{5}X%f)%f%b "
    [[ $PWD == $HOME ]] || PROMPT="%F{8}%1d%f$branch $PROMPT"
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd set-prompt

#############
## ALIASES ##
#############

# Dotfiles
alias bed="bedside"

# Fzf
alias pac-install="pacman -Slq | fzf --multi --preview 'pacman -Si {1}' | xargs -ro doas pacman -S"
alias pac-uninstall="pacman -Qq | fzf --multi --preview 'pacman -Qi {1}' | xargs -ro doas pacman -Rns"

d() {
    dir="$(find $HOME -maxdepth 4 -type d | fzf)"
    [[ -z $dir ]] || cd "$dir"
}

# Basics
alias ..="cd .."
alias ...="cd ../.."
alias ls="ls --color --group-directories-first --quoting-style=literal -pq --show-control-chars"
alias l="ls -lah --time-style='+%d-%m-%y'"
alias mv="mv -iv"
alias cp="cp -riv"
alias mkdir="mkdir -vp"
alias rm="rm -vI"
alias c="clear"
alias grep="grep -i -H -n --color"

# Various
alias mpv="linkhandler -m"
alias yt-dlp="linkhandler -d"
alias e="dmenu-editor-history --open"
alias py="python3"
alias nf="neofetch"
alias storage="df -h -x tmpfs"

overview() {
    du -h --max-depth=1 | sed -r '$d; s/^([.0-9]+[KMGTPEZY]\t)\.\//\1/' \
    | sort -hr | column
}

# Git
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gr="git rm --cached"
alias gp="git push"

# Wifi
alias wifi-list="nmcli device wifi list"
alias wifi-known="nmcli connection show"
alias wifi-connect="nmcli --ask device wifi connect"
alias wifi-disconnect="nmcli connection delete"
alias wifi-enable="nmcli radio wifi on"
alias wifi-disable="nmcli radio wifi off"


######################
## COMPLETION SETUP ##
######################

# Improving tab completion (menu, case-insensitive etc.)
autoload -U compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' list-colors ''
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories
zmodload zsh/complist
compinit

#############
## VI MODE ##
#############

bindkey -v
export KEYTIMEOUT=1

#################
## KEYBINDINGS ##
#################

# Vim keys in tab complete menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Home, end, delete keys
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[3~" delete-char
