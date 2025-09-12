#!/bin/sh

obsidian_dir="$HOME/Documents/Obsidian"
# time_stamp=$(date +"%d%m%y-%H%M%S%3N")
# notes_dir="$obsidian_dir/tmp"
# target_file="$notes_dir/tmp-$time_stamp.md"

# Check if the directory exists
if [ ! -d "$obsidian_dir" ]; then
  echo "Error: $obsidian_dir does not exist." >&2
  exit 1
fi

session_name="Notes"

# Check if a tmux session with the same name already exists
if tmux has-session -t "$session_name" 2>/dev/null; then
  notify-send -a "TMUX: Notes" "Attatched to the notes session"
  tmux attach-session -t "$session_name"
  exit 0
fi

# Create a new tmux session
notify-send -a "TMUX: Notes" "New notes sessies has been created"
tmux new-session -d -s "$session_name" -c "$obsidian_dir"

# Rename the first window
tmux rename-window -t "$session_name":1 "NVIM"

# Send command to open nvim in the NVIM window
tmux send-keys -t "$session_name":"NVIM" "nvim" C-m

# Attach to the NVIM window of the new session
tmux attach-session -t "$session_name":"NVIM"

exit 0
