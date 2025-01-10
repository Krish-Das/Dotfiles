#!/bin/sh

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

# Edit files from .config and .local/bin directory
conf() {
  file=$(find "$HOME/.config" "$HOME/.local/bin" "$HOME/.zshrc"  -maxdepth 2 -type f \
    | grep -vi "/chromium" \
    | grep -vi "/pulse" \
    | fzf --cycle)

  [ -n "$file" ] && nvim "$file"
}

# Open codeground
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

silent () {
  if command -v "$1" > /dev/null; then
    setsid "$1" > /dev/null 2>&1 &
    printf "\033[32mRan %s in background silently.\033[0m\n" "$1"
  else
    printf "\033[31mError: %s is not a valid command.\033[0m\n" "$1"
  fi
}

# Preview images in Downloads and Pictures directory
fuzzy_image_search() {
  printf "\033[1mThis function is not fully developed yet!\033[0m\n\n"

  # local extensions=("\\.svg$" "\\.png$" "\\.jpg$" "\\.jpeg$" "\\.webp$" "\\.gif$" "\\.bmp$" "\\.tiff$" "\\.pbm$" "\\.pgm$" "\\.ppm$")
  # local find_command="find \"$HOME/Downloads\" \"$HOME/Pictures\" -type f -iregex"
  #
  # for ext in "${extensions[@]}"
  # do
  #   find_command+=" -o -iregex \".*$ext\""
  # done
  #
  # # Print fzf multi-select in one line, separated by a space
  # local selected_file=$(eval "$find_command | fzf -m --print0" | tr '\0' ' ' | sed 's/ / /g')
  #
  # if [[ -n $selected_file ]]; then
  #   echo "Viewing images ..."
  #
  #   for file in $selected_file 
  #   do
  #     echo -e "\e[1;94m$file\e[0m"
  #   done
  #
  #   # View images using feh
  #   feh -. $selected_file
  # fi
}
