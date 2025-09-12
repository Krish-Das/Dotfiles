#!/bin/sh

source_file="$HOME/Downloads/notion.zip"
tmp_folder="$HOME/Downloads/__tmp_ykw_notion"
dest_folder="$HOME/Documents/Obsidian/ykw"

# Unzip into temporary dir
if ! mkdir -pv "$tmp_folder" >/dev/null; then
  echo "Error: Failed to create temporary directory."
  exit 1
fi

if ! unzip "$source_file" -d "$tmp_folder" >/dev/null; then
  echo "Error: Failed to unzip the file."
  exit 1
fi

# Get the target file and do some checks:
target_file=$(fd "YKW" -s -t f "$tmp_folder")
if [ "$(echo "$target_file" | wc -l)" -gt 1 ]; then
  echo "---"
  echo "Error: More than one file found!"
  echo "Manual intervention required."
  exit 1
elif [ -z "$target_file" ]; then
  echo "Error: No files found."
  exit 1
else
  mv "$target_file" "$dest_folder/notion.md"
  trash-put "$tmp_folder"
  trash-put "$source_file"
  echo "Pasting completed!"
  exit 0
fi
