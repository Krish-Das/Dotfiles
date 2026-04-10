#!/usr/bin/env sh

CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/quickshell"
LAUNCHER="$CONFIG_DIR/launcher.qml"

if [ ! -f "$LAUNCHER" ]; then
  notify-send "Launcher" "Not found: $LAUNCHER"
  exit 1
fi

if ! qs ipc --path "$LAUNCHER" call launcher toggle 2>/dev/null; then
  notify-send "Launcher" "IPC failed — is quickshell running?"
  exit 1
fi
