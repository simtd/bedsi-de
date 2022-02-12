############
## PROMPT ##
############

function set-prompt() {
    local git_branch="$(git rev-parse --abbrev-ref HEAD 2>/dev/null)"
    [[ -z $git_branch ]] || git_branch=" %F{8}${git_branch//\%/%%}%f"
    local newline=$'\n'
    PROMPT="%F{4}%2d%f$git_branch%B%F{1}%(?.. [%?])%f%b%B%F{5}$newline>%f%b "
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
alias grep="grep -i -H -n --color -A 5 -B 2"
alias c="clear"

alias bedsi="git --git-dir=$HOME/.bedsi-de/ --work-tree=$HOME"
alias beds="bedsi status"
alias bedsrm="bedsi rm --cached"

alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gr="git rm --cached"
alias gp="git push"

alias mpv="setsid -f mpv --no-terminal --ytdl-format='(bestvideo[height<=?1080]+bestaudio/best)'"
alias yt-dlp="yt-dlp -f '(bestvideo[height<=?1080]+bestaudio/best)'"

alias e="dmenu-editor-history --open"
alias open="xdg-open"
alias py="python3"
alias ac="arduino-cli"
alias cb="checkbashisms"
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
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
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
