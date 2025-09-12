#!/bin/sh

# Get the current date and time
time_stamp=$(date +"%d%m%y-%H%M%S%3N")

# File path and name
file_path="$HOME"/Pictures/Screenshots
file_name=Screenshot-"$time_stamp"
file_ext=".png"

# Use awk to extract the simplified path
simple_path=$(echo "$file_path" | awk -F"$HOME/" '{print $2}')

grim "$file_path"/"$file_name""$file_ext"
notify-send "Screenshot saved" "in $simple_path" -t 1000

# Selected region
# grim -g "$(slurp -c #FF0000FF -d)"
