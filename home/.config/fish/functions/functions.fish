#!/usr/bin/env fish

function a --wraps=b --description 'alias a=b'
    b $argv
end

# Edit the dotfiles
function conf
  set dotfiles_dir "$HOME/dotfiles"
  set selected_files (find "$dotfiles_dir" -maxdepth 4 -type f | \
    grep -v "^$dotfiles_dir/.git/" | \
    fzf --cycle)

  if test -n "$selected_files"
    $EDITOR "$selected_files"
  else
    echo "No files selected."
  end
end

# Open Repos
function code
  set file (find "$HOME/Repos" -maxdepth 1 -type d | grep -i "/Repos/" | fzf --cycle)
  test -n "$file"; and cd "$file"
end

function silent
  if not command -v $argv[1] &>/dev/null
    set_color red
    echo "Error: $argv[1] is not a valid command."
    set_color normal
    return 127
  end

  fish -c "$argv" &>/dev/null &
  set pid (jobs -lp | tail -n1)
  disown $pid

  set_color green
  echo "Ran $argv in background silently (PID: $pid)."
  set_color normal
end
complete -c silent -a '(__fish_complete_subcommand)'
