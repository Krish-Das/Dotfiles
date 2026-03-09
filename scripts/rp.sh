#!/bin/sh
# rp - Repo navigator: fuzzy-pick a project or worktree under ~/Repos and print the path.
# Meant to be called by the `rp` shell function (see bottom of file) which does the actual cd.
#
# Usage:
#   rp            - pick from top-level projects
#   rp <project>  - pick from worktrees of <project> (falls back to project root if none)
#   rp -h|--help  - show this help

# ---------------------------------------------------------------------------
# Global constants
# ---------------------------------------------------------------------------
readonly REPOS_DIR="$HOME/Repos"
readonly WORKTREE_DIR="_worktree"

# ---------------------------------------------------------------------------
# usage
#   Prints help text to stdout.
#   Input : none
#   Output: help text
#   Called by: main
# ---------------------------------------------------------------------------
usage() {
  cat <<EOF
Usage: rp [project] [-h|--help]

  rp                Pick a project from $REPOS_DIR and cd into it.
  rp <project>      Pick a worktree of <project> (or the project root) and cd into it.
  rp -h|--help      Show this help.

Worktrees are expected at: $REPOS_DIR/$WORKTREE_DIR/<project>/<branch>
EOF
}

# ---------------------------------------------------------------------------
# pick_project
#   Lists top-level directories in REPOS_DIR (excluding _worktree), pipes to fzf.
#   Input : none
#   Output: selected project name (stdout), empty if aborted
#   Called by: main
# ---------------------------------------------------------------------------
pick_project() {
  fd --min-depth 1 --max-depth 1 --type d \
    --exclude "$WORKTREE_DIR" \
    . "$REPOS_DIR" |
    sed "s|$REPOS_DIR/||" |
    fzf --prompt="project> "
}

# ---------------------------------------------------------------------------
# pick_worktree
#   Lists worktree branches for a given project plus the project root itself.
#   Input : $1 = project name
#   Output: absolute path of selected entry (stdout), empty if aborted
#   Called by: main
# ---------------------------------------------------------------------------
pick_worktree() {
  project="$1"
  wt_base="$REPOS_DIR/$WORKTREE_DIR/$project"
  root_entry="[root] $project"

  # Build list: root first, then any worktree branches
  if [ -d "$wt_base" ]; then
    branches=$(fd --min-depth 1 --max-depth 1 --type d . "$wt_base" |
      sed "s|$wt_base/||")
    list=$(printf '%s\n%s\n' "$root_entry" "$branches")
  else
    list="$root_entry"
  fi

  selected=$(printf '%s\n' "$list" | fzf --prompt="worktree> ")
  [ -z "$selected" ] && return

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
#   Output: resolved absolute path printed to stdout (consumed by shell function)
#   Called by: shell function `rp`
# ---------------------------------------------------------------------------
main() {
  case "$1" in
  -h | --help)
    usage
    exit 0
    ;;
  "")
    project=$(pick_project)
    [ -z "$project" ] && exit 1
    printf '%s\n' "$REPOS_DIR/$project"
    ;;
  *)
    project="$1"
    if [ ! -d "$REPOS_DIR/$project" ]; then
      printf 'rp: project "%s" not found in %s\n' "$project" "$REPOS_DIR" >&2
      exit 1
    fi
    path=$(pick_worktree "$project")
    [ -z "$path" ] && exit 1
    printf '%s\n' "$path"
    ;;
  esac
}

main "$@"

# ---------------------------------------------------------------------------
# Shell function — paste this into your ~/.bashrc / ~/.zshrc / ~/.profile
# ---------------------------------------------------------------------------
# rp() {
#     path=$(command rp "$@") && cd "$path"
# }
