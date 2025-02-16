#!/bin/sh

source_file="$HOME/Downloads/notion.zip"
tmp_folder="$HOME/Downloads/__tmp_ykw_notion"
dest_folder="$HOME/Documents/Obsidian/ykw"

mkdir -pv "$tmp_folder"
unzip "$source_file" -d "$tmp_folder"
mv "$tmp_folder"/YKW*.md "$dest_folder/notion.md"

trash-put "$tmp_folder"
trash-put "$source_file"
