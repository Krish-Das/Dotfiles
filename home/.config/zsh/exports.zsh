#!/usr/bin/env sh
# vim:fileencoding=utf-8:ft=sh

# HISTFILE="$XDG_CACHE_HOME/zsh/history"
HISTSIZE=1000000
SAVEHIST=1000000

export EDITOR="nvim"
export TERMINAL="alacritty"
export EXPLORER="thunar"
export BROWSER="chromium"

export XDG_CONFIG_HOME="$HOME"/.config
export XDG_CACHE_HOME="$HOME"/.cache
export XDG_DATA_HOME="$HOME"/.local/share

export PATH="$HOME/.local/bin:$PATH"

export MANPAGER='nvim +Man!'
export MANWIDTH=999

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export TOCK_FILE="$XDG_CACHE_HOME/.tock.txt"
