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

# Edit the dotfiles with one command
conf() {
  dotfiles_dir="$HOME/dotfiles"
  selected_files=$(find "$dotfiles_dir" -maxdepth 4 -type f |
    grep -v '^'"$dotfiles_dir"'/.git/' |
    fzf --cycle)

  [ -n "$selected_files" ] && $EDITOR "$selected_files" || echo "No files selected."
}

# Open Repos
code() {
  file=$(find "$HOME/Repos" -maxdepth 1 -type d | grep -i "/Repos/" | fzf --cycle)
  [ -n "$file" ] && cd "$file"
}

icat() {
  if [ "$TERM" = "xterm-kitty" ]; then
    kitten icat "$@"
  elif [ "$TERM" = "alacritty" ]; then
    echo "You are using Alacritty. Please use Kitty to display images with icat."
  else
    echo "This terminal does not support icat. Please use Kitty."
  fi
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
