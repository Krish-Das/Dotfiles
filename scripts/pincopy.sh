#!/usr/bin/env bash
set -euo pipefail

f="${XDG_STATE_HOME:-$HOME/.local/state}/pincopy/clips.txt"

usage() {
  cat <<EOF
Usage: pincopy [-e|--edit] [-h|--help]

  -e, --edit   edit the clips file (\$EDITOR)
  -h, --help   show this help
EOF
}

case "${1:-}" in
-h | --help)
  usage
  exit 0
  ;;
-e | --edit)
  exec "${EDITOR:-vi}" "$f"
  ;;
"") ;; # no args, fall through to picker
*)
  echo "pincopy: unknown option: $1" >&2
  usage >&2
  exit 1
  ;;
esac

[[ -s "$f" ]] || {
  echo "pincopy: $f missing or empty" >&2
  exit 1
}

sel=$(fzf --cycle <"$f") || exit 0 # empty selection / Esc = clean exit, not error
printf '%s' "$sel" | wl-copy
