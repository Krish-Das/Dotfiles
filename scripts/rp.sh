#!/usr/bin/env sh
# rp - Repo navigator: fuzzy-pick a project or worktree under ~/Repos.
# Outputs the selected path to stdout only — the shell function handles cd.
#
# Usage:
#   rp                        - pick a project and print its path
#   rp <project>              - pick a worktree of <project> and print its path
#   rp -h|--help              - show this help
#
# Examples:
#   rp                        - lists One, Two, Three → prints ~/Repos/One
#   rp Two                    - lists [root] Two, feature-x → prints ~/Repos/_worktree/Two/feature-x
#
# This script only prints paths. To cd, add the rp() function to your ~/.zshrc:
#
#   rp() {
#     case "$1" in
#       -h|--help) "$HOME/.local/bin/rp.sh" "$@" ;;
#       *)         cd "$("$HOME/.local/bin/rp.sh" "$@")" || return 1 ;;
#     esac
#   }

# ---------------------------------------------------------------------------
# Global constants
# ---------------------------------------------------------------------------
readonly REPOS_DIR="$HOME/Repos"
readonly WORKTREE_DIR="_worktree"

# ---------------------------------------------------------------------------
# usage
#   Prints help text to stderr (keeps stdout clean for path output).
#   Input : none
#   Output: help text on stderr
#   Called by: main
# ---------------------------------------------------------------------------
usage() {
  printf 'Usage: rp [project] [-h|--help]\n\n' >&2
  printf '  rp                Pick a project from %s and print its path.\n' "$REPOS_DIR" >&2
  printf '  rp <project>      Pick a worktree of <project> (or the project root) and print its path.\n' >&2
  printf '  rp -h|--help      Show this help.\n\n' >&2
  printf 'Worktrees are expected at: %s/%s/<project>/<branch>\n' "$REPOS_DIR" "$WORKTREE_DIR" >&2
}

# ---------------------------------------------------------------------------
# pick_project
#   Lists top-level directories in REPOS_DIR (excluding _worktree), pipes to fzf.
#   Input : none
#   Output: selected project name on stdout, empty if aborted
#   Called by: main
# ---------------------------------------------------------------------------
pick_project() {
  fd --min-depth 1 --max-depth 1 --type d \
    --exclude "$WORKTREE_DIR" \
    . "$REPOS_DIR" |
    sed "s|$REPOS_DIR/||;s|/$||" |
    fzf --cycle --prompt="project> "
}

# ---------------------------------------------------------------------------
# pick_worktree
#   Lists the project root and any worktree branches for a given project.
#   Input : $1 = project name
#   Output: absolute path of selected entry on stdout, empty if aborted
#   Called by: main
# ---------------------------------------------------------------------------
pick_worktree() {
  project="$1"
  wt_base="$REPOS_DIR/$WORKTREE_DIR/$project"
  root_entry="[root] $project"

  if [ -d "$wt_base" ]; then
    branches=$(fd --min-depth 1 --max-depth 1 --type d . "$wt_base" |
      sed "s|$wt_base/||")
    list=$(printf '%s\n%s\n' "$root_entry" "$branches")
  else
    list="$root_entry"
  fi

  selected=$(printf '%s\n' "$list" | fzf --cycle --prompt="worktree> ")
  [ -z "$selected" ] && return 1

  if [ "$selected" = "$root_entry" ]; then
    printf '%s\n' "$REPOS_DIR/$project"
  else
    printf '%s\n' "$wt_base/$selected"
  fi
}

# ---------------------------------------------------------------------------
# main
#   Entry point. Parses args, delegates to pick_project or pick_worktree.
#   Input : CLI args
#   Output: resolved absolute path on stdout, exits non-zero on failure
#   Called by: shell function `rp` in ~/.zshrc
# ---------------------------------------------------------------------------
main() {
  case "$1" in
  -h | --help)
    usage
    return 0
    ;;
  "")
    project=$(pick_project)
    [ -z "$project" ] && return 1
    printf '%s\n' "$REPOS_DIR/$project"
    ;;
  *)
    project="$1"
    if [ ! -d "$REPOS_DIR/$project" ]; then
      printf 'rp: project "%s" not found in %s\n' "$project" "$REPOS_DIR" >&2
      return 1
    fi
    path=$(pick_worktree "$project")
    [ -z "$path" ] && return 1
    printf '%s\n' "$path"
    ;;
  esac
}

main "$@"

# ---------------------------------------------------------------------------
# Add to ~/.zshrc:
#
#   rp() {
#     case "$1" in
#       -h|--help) "$HOME/.local/bin/rp.sh" "$@" ;;
#       *)         cd "$("$HOME/.local/bin/rp.sh" "$@")" || return 1 ;;
#     esac
#   }
# ---------------------------------------------------------------------------
