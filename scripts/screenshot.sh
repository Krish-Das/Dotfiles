#!/usr/bin/env sh

time_stamp=$(date +"%d%m%y-%H%M%S%3N")

# File path and name
file_path="$HOME"/Pictures/Screenshots
file_name=screenshot-"$time_stamp"
file_ext=".png"

# Use awk to extract the simplified path
simple_path=$(echo "$file_path" | awk -F"$HOME/" '{print $2}')

# Monitor Selection
selected_monitors=$(hyprctl monitors | awk '/^Monitor/ {print $2}' | tofi)
[ -z "$selected_monitors" ] && { exit 0; }

notify-send "Screenshot saved" "in $simple_path" -t 1000
grim -o "$selected_monitors" "$file_path"/"$file_name""$file_ext"

# Selected region
# grim -g "$(slurp -c #FF0000FF -d)"
