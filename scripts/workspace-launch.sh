#!/bin/sh

# Execute command silently in background and report status
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

# Launch Hyprland workspace with specified command
launch_workspace() {
  workspace=$1
  shift
  silent hyprctl dispatch exec "[workspace $workspace silent] $*"
}

# ghostty -e sh -c "tmux"
launch_workspace 1 "env -u WAYLAND_DISPLAY zeditor"
launch_workspace 2 wezterm
launch_workspace 3 "flatpak run app.zen_browser.zen"
launch_workspace 3 "google-chrome-stable"
launch_workspace 10 wezterm
