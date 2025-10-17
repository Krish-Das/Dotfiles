#!/usr/bin/env sh
# vim:fileencoding=utf-8:ft=sh

# To profile zsh startup time. Look at the end of this file
# zmodload zsh/zprof

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"

# history
HISTFILE="$HOME/.zsh_history"

setopt hist_ignore_dups     # do not record an event that was just recorded again
setopt hist_ignore_all_dups # delete an old recorded event if a new event is a duplicate
setopt hist_ignore_space    # do not record an event starting with a space
setopt hist_save_no_dups    # do not write a duplicate event to the history file
setopt inc_append_history   # write to the history file immediately, not when the shell exits
setopt share_history        # share history between terminals

# fzf in terminal, fzf must be installed to use this
eval "$(fzf --zsh)"

# source
plug "$HOME/.config/zsh/aliases.zsh"
plug "$HOME/.config/zsh/exports.zsh"
plug "$HOME/.config/zsh/functions.zsh"

# Load local environment variables if the file exists
if [ -f "$HOME/.config/env/local.env" ]; then
  plug "$HOME/.config/env/local.env"
fi

# plugins
plug "zsh-users/zsh-autosuggestions"
plug "zap-zsh/vim"
plug "zsh-users/zsh-syntax-highlighting"
plug "zsh-users/zsh-history-substring-search"
plug "Aloxaf/fzf-tab"
plug "romkatv/powerlevel10k"

#
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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# bun completions
# [ -s "/home/mavx/.bun/_bun" ] && source "/home/mavx/.bun/_bun"

# Other part of profiling zsh startup time
# this will write the output to /tmp/zprof_dump
# zprof > /tmp/zprof_dump
