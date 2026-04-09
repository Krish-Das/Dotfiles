#!/usr/bin/env sh

# Bail if niri isn't running
niri msg --json workspaces >/dev/null 2>&1 || {
  echo "niri is not running" >&2
  exit 1
}

workspaces=$(niri msg --json workspaces | jq -r '.[] | "[\(.idx)] \(.name // "")"')

# Bail if no workspaces returned
[ -z "$workspaces" ] && {
  echo "no workspaces found" >&2
  exit 1
}

selected=$(echo "$workspaces" | tofi)

# Bail if user cancelled (empty selection)
[ -z "$selected" ] && exit 0

idx=$(echo "$selected" | grep -o '^\[[0-9]*\]' | tr -d '[]')

# Bail if idx couldn't be parsed
[ -z "$idx" ] && {
  echo "failed to parse workspace index" >&2
  exit 1
}

niri msg action focus-workspace "$idx"
