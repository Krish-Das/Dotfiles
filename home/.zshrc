#!/usr/bin/env sh

# To profile zsh startup time. Look at the end of this file
# zmodload zsh/zprof

# Load zap plugin manager
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && . "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"

# Load local environment variables
[ -f "$HOME/.config/env/local.env" ] && . "$HOME/.config/env/local.env"

# history
HISTFILE="$HOME/.zsh_history"

setopt autocd                   # change directory just by typing the name
setopt interactivecomments      # allow # to start comments in interactive commands
setopt hist_ignore_dups         # do not record an event that was just recorded again
setopt hist_ignore_all_dups     # delete an old recorded event if a new event is a duplicate
setopt hist_expire_dups_first
setopt hist_ignore_space        # do not record an event starting with a space
setopt hist_save_no_dups        # do not write a duplicate event to the history file
setopt hist_verify
setopt inc_append_history       # write to the history file immediately, not when the shell exits
setopt share_history            # share history between terminals

# fzf in terminal, fzf must be installed to use this
eval "$(fzf --zsh)"
eval "$(starship init zsh)"

# source
plug "$HOME/.config/zsh/exports.zsh"
plug "$HOME/.config/zsh/aliases.zsh"
plug "$HOME/.config/zsh/functions.zsh"

# completion for toc cli
# https://github.com/kriuchkov/tock
plug "$HOME/.config/tock/tock.zsh"

# plugins
plug "zsh-users/zsh-autosuggestions"
plug "zap-zsh/vim"
plug "zsh-users/zsh-syntax-highlighting"
plug "zsh-users/zsh-history-substring-search"
plug "Aloxaf/fzf-tab"

# Load and initialise completion system
# Don't need this if fzf is enabled
# Disabling the compinit also reduces the startup time
#
# autoload -Uz compinit
# compinit
# zstyle ':completion:*' menu no
# zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Keybindings
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# Other part of profiling zsh startup time
# this will write the output to /tmp/zprof_dump
# zprof >/tmp/zprof_dump
