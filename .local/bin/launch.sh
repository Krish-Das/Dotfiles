#!/bin/sh

silent() {
  if command -v "$1" >/dev/null; then
    "$@" >/dev/null 2>&1 &
    pid=$!
    printf "\033[32mRan %s in background silently (PID: %d).\033[0m\n" "$*" $pid
  else
    printf "\033[31mError: %s is not a valid command.\033[0m\n" "$1"
    return 127
  fi
}

# ghostty -e sh -c 'tmux'
silent ghostty
silent ghostty
silent firefox
silent flatpak run com.google.Chrome
silent flatpak run app.zen_browser.zen
