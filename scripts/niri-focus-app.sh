#!/usr/bin/env sh

usage() {
  echo "usage: $(basename "$0") <app-id>"
  echo "example: $(basename "$0") org.wezfurlong.wezterm"
}

case "$1" in
-h | --help)
  usage
  exit 0
  ;;
esac

app_id=$1

if [ -z "$app_id" ]; then
  usage >&2
  exit 1
fi

# Bail if niri isn't running
niri msg --json workspaces >/dev/null 2>&1 || {
  echo "niri is not running" >&2
  exit 1
}

id=$(niri msg --json windows | jq -r --arg app_id "$app_id" '
  [.[] | select(.app_id == $app_id) | .id][0] // empty
')

if [ -z "$id" ]; then
  echo "Error: no window found with app_id '$app_id'" >&2
  exit 1
fi

niri msg action focus-window --id "$id"
