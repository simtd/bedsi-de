############
## PROMPT ##
############

function truncated_path() {
    local i pwd
    pwd=("${(s:/:)PWD/#$HOME/~}")
    if (( $#pwd > 1 )); then
        for i in {1..$(($#pwd-1))}; do
            if [[ "$pwd[$i]" = .* ]]; then
                pwd[$i]="${${pwd[$i]}[1,2]}"
            else
                pwd[$i]="${${pwd[$i]}[1]}"
            fi
        done
    fi
    echo "${(j:/:)pwd}"
}

function set-prompt() {
    local git_branch="$(git rev-parse --abbrev-ref HEAD 2>/dev/null)"
    [[ -z $git_branch ]] || git_branch=" %F{6}${git_branch//\%/%%}%f"
    PROMPT="%F{4}$(truncated_path)%f$git_branch%B%F{1}%(?.. [%?])%f%b %B%F{5}>%f%b "
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd set-prompt

#############
## ALIASES ##
#############

alias ..="cd .."
alias ls="ls --color"
alias l="ls -lah --time-style='+%d-%m-%y'"
alias mv="mv -iv"
alias cp="cp -riv"
alias mkdir="mkdir -vp"
alias rm="rm -vI"
alias grep="grep -i --color"
alias c="clear"

alias bedsi="git --git-dir=$HOME/.bedsi-de/ --work-tree=$HOME"
alias beds="bedsi status"

alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gr="git rm --cached"
alias gp="git push"

alias mpv="setsid -f mpv --no-terminal"
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

#############
## VI MODE ##
#############

bindkey -v
export KEYTIMEOUT=1

function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # use beam shape cursor on startup
preexec() { echo -ne '\e[5 q' ;} # use beam shape cursor for each new prompt

#################
## COMPLETIONS ##
#################

# improving tab completion (menu, case-insensitive etc.)
autoload -U compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zmodload zsh/complist
compinit
_comp_options+=(globdots)

#############
## HISTORY ##
#############

# searching history up arrow based on what's typed in
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end

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
