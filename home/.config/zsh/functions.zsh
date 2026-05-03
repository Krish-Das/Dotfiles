#!/usr/bin/env sh
# vim:fileencoding=utf-8:ft=sh

# █▀▀ █░█ █▄░█ █▀▀ ▀█▀ █ █▀█ █▄░█ █▀
# █▀░ █▄█ █░▀█ █▄▄ ░█░ █ █▄█ █░▀█ ▄█

S() {
  package_name="$1"

  if [ -z "$package_name" ]; then
    echo "Please provide a package name to search."
    return 1
  fi

  echo "Searching in Pacman repository:"
  pacman -Ss "$package_name"

  echo
  echo "Searching in AUR (via yay):"
  yay -Ss "$package_name"
}

# load bun completions on demand
buncomp() {
  [ -s "${BUN_INSTALL:-$HOME/.bun}/_bun" ] && . "${BUN_INSTALL:-$HOME/.bun}/_bun"
}

# Edit the dotfiles with one command
conf() {
  dotfiles_dir="$HOME/dotfiles"
  selected_files=$(find "$dotfiles_dir" -maxdepth 4 -type f |
    grep -v '^'"$dotfiles_dir"'/.git/' |
    fzf --cycle)

  [ -n "$selected_files" ] && $EDITOR "$selected_files" || echo "No files selected."
}

# Cache SSH key for 1 hour
ssh-cache() {
  ssh-add -t 3600 ~/.ssh/id_ed25519 2>/dev/null
}

# Open projects
rp() {
  case "$1" in
  -h | --help) "$HOME/.local/bin/rp.sh" "$@" ;;
  *) cd "$("$HOME/.local/bin/rp.sh" "$@")" || return 1 ;;
  esac
}

silent() {
  if command -v "$1" >/dev/null; then
    "$@" &>/dev/null &!
    pid=$!
    printf "\033[32mRan %s in background silently (PID: %d).\033[0m\n" "$*" $pid
  else
    printf "\033[31mError: %s is not a valid command.\033[0m\n" "$1"
    return 127
  fi
}
compdef _precommand silent # enable tab completion
