#!/usr/bin/env bash
# vim:fileencoding=utf-8:ft=sh

# XDG standard directories
declare -a folders=(
  "Desktop"
  "Documents"
  "Downloads"
  "Music"
  "Pictures"
  "Videos"
  "Templates"
  "Public"
)

create_folder() {
  local folder_path="$1"
  echo "Creating: $folder_path"
  mkdir -p "$folder_path"
}

# Loop through each folder
for folder in "${folders[@]}"; do
  folder_path="$HOME/$folder"

  # If the folder does not exist
  if [[ ! -d "$folder_path" ]]; then
    create_folder "$folder_path"
  else
    echo "Skipping: $folder folder already exist"
  fi
done
