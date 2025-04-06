#!/bin/sh

# Set the target directory
repos_dir="$HOME/Repos"

# Check if the directory exists
if [ ! -d "$repos_dir" ]; then
  echo "Error: $repos_dir does not exist." >&2
  exit 1
fi

# Find all directories directly inside the repos directory
directories=$(find "$repos_dir" -maxdepth 1 -type d -not -path "$repos_dir" | sed 's:^'"$repos_dir"'/::')

# Check if any directories were found
if [ -z "$directories" ]; then
  echo "No directories found in $repos_dir." >&2
  exit 1
fi

# Use fzf to select a directory
selected_directory=$(echo "$directories" | fzf -m --cycle)

# Check if a directory was selected
if [ -z "$selected_directory" ]; then
  echo "No directory selected." >&2
  exit 1
fi

# Set the session name to the selected directory name
session_name="$selected_directory"

# Construct the full path to the selected directory
full_path="$repos_dir/$selected_directory"

# Check if a tmux session with the same name already exists
if tmux has-session -t "$session_name" 2>/dev/null; then
  notify-send -a "TMUX" "Attatch to session: $session_name"
  tmux attach-session -t "$session_name"
  exit 0
fi

# Create a new tmux session
tmux new-session -d -s "$session_name" -c "$full_path"

# Create the first window (it already exists by default)
tmux rename-window -t "$session_name":1 "NVIM"

# Create the second window
tmux new-window -t "$session_name" -c "$full_path" -n "LazyGit"

# Create the third window
tmux new-window -t "$session_name" -c "$full_path" -n "Terminal"

# Attach to the NVIM window of the new session
tmux attach-session -t "$session_name":"NVIM"

notify-send -a "TMUX" "New session created: $session_name"
echo "Tmux session '$session_name' created in '$full_path'."
exit 0
