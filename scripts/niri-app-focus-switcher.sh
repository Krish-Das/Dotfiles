#!/usr/bin/env sh

# Bail if niri isn't running
niri msg --json workspaces >/dev/null 2>&1 || {
  echo "niri is not running" >&2
  exit 1
}

app_ids=$(niri msg --json windows | jq -r '.[].app_id' | sort -u)

[ -z "$app_ids" ] && {
  echo "no windows found" >&2
  exit 1
}

selected=$(printf '%s\n' "$app_ids" | fuzzel --dmenu)

[ -z "$selected" ] && exit 0

niri-focus-app.sh "$selected"
