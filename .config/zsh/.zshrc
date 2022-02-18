############
## PROMPT ##
############

function set-prompt() {
    local branch="$(git rev-parse --abbrev-ref HEAD 2>/dev/null)"
    [[ -z $branch ]] || branch=" %F{8}${branch//\%/%%}%f"
    # local newline=$'\n'
    PROMPT="%F{6}%1d%f$branch %B%(?.%F{5}>%f.%F{1}%?%f %F{5}X%f)%f%b "
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd set-prompt

#############
## ALIASES ##
#############

alias ..="cd .."
alias ...="cd ../.."

alias ls="ls --color"
alias l="ls -lah --time-style='+%d-%m-%y'"
alias mv="mv -iv"
alias cp="cp -riv"
alias mkdir="mkdir -vp"
alias rm="rm -vI"
# alias grep="grep -i -H -n --color -A 5 -B 2"
alias grep="grep -i -H -n --color"
alias c="clear"

alias bedsi="git --git-dir=$HOME/.bedsi-de/ --work-tree=$HOME"
alias beds="bedsi status"
alias bedsrm="bedsi rm --cached"

alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gr="git rm --cached"
alias gp="git push"

alias mpv="linkhandler -m"
alias yt-dlp="linkhandler -d"

alias e="dmenu-editor-history --open"
alias py="python3"
alias nf="neofetch"

alias storage="df -h -x tmpfs"
alias wifi-list="nmcli device wifi list"
alias wifi-known="nmcli connection show"
alias wifi-connect="nmcli --ask device wifi connect"
alias wifi-disconnect="nmcli connection delete"
alias wifi-enable="nmcli radio wifi on"
alias wifi-disable="nmcli radio wifi off"

###############
## FUNCTIONS ##
###############

# quick jump directories with fzf
d() {
    dir="$(find $HOME -maxdepth 3 -type d -printf '%P\n' | fzf --no-multi)"
    cd "$HOME/$dir"
}

#################
## COMPLETIONS ##
#################

# improving tab completion (menu, case-insensitive etc.)
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

# vim keys in tab complete menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# home, end, delete keys
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[3~" delete-char
