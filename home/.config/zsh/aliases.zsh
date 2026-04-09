#!/usr/bin/env sh
# vim:fileencoding=utf-8:ft=sh

# Colorize grep output (good for log files)
alias grep="grep --color=auto"
alias egrep="egrep --color=auto"
alias fgrep="fgrep --color=auto"

# Publish date (MM-DD-YYYY) for mdx
alias pdate='date +"%m-%d-%Y"'
alias timestamp='date +"%d%m%y-%H%M%S%3N"'
alias scrcpy='scrcpy --render-driver=opengl'

# settings for common commands
alias e="$EDITOR"
alias ya="yazi"
alias fetch="fastfetch"
alias lg="lazygit"
alias cp="cp -iv"
alias mv="mv -iv"
alias rm="rm -vI"
alias bc="bc -ql"
alias mkd="mkdir -pv"
alias ls="eza --icons --group-directories-first"
alias tree="eza -T"
alias bat="bat -p"
alias c="wl-copy"
alias open="$EXPLORER"
# alias c="xclip -selection clipboard"
# alias lf="lfcd"
# alias locate="plocate"

alias tp="trash-put"
alias tpr="trash-restore"

alias s="echo no-sirski!"
alias N="niri --session"
alias H="start-hyprland"

alias notes="notes.sh"
alias proj="projects.sh"

alias Trash="cd \$XDG_DATA_HOME/Trash/files"
alias run="cd /run/media/$USER"
alias dots="cd \$HOME/dotfiles"

# git aliases
alias g="git"
alias gst="git status"
alias gcm="git commit"
alias gad="git add"
alias gpl="git pull"
alias gpu="git push"
alias gd="git diff"
alias gch="git checkout"
alias gnb="git checkout -b"
alias gac="git add . && git commit"
alias grs="git restore --staged ."
alias gre="git restore"
alias gcl="git clone"
alias glg="git log --graph --abbrev-commit --decorate --format=format:'%C(bold green)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold yellow)(%ar)%C(reset)%C(auto)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all"
alias gt="git ls-tree -r master --name-only"
alias grm="git remote"
alias gbr="git branch"
alias gf="git fetch"

# easier to read disk
alias df='df -h'     # human-readable sizes
alias free='free -m' # show sizes in MB

# get top process eating memory
alias psmem='ps auxf | sort -nr -k 4 | head -5'

# get top process eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3 | head -5'

# systemd
alias mach_list_systemctl="systemctl list-unit-files --state=enabled"

# Check startup time of zsh
alias zsh_time="time zsh -i -l -c exit"
