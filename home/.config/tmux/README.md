## Setup TPM to manage plugins

1. The first time you need to clone the `tpm` repository manually.

   ```sh
   mkdir -pv ~/.config/tmux/plugins/tpm

   git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
   ```

2. Add the following line at the end of your `tmux.conf` file. (You might already have it there)

   ```conf
   run '~/.config/tmux/plugins/tpm/tpm'
   ```

3. Then press `prefix -> I` and done.

   Now you can install any plugins using TPM. Just put them in the `.conf` file.

   ```conf
   set -g @plugin 'tmux-plugins/tpm'
   ```

## Commands notes:

### crate new session

```
tmux new -s <session-name>
```

### list all session

```
tmux ls
```

### Attatch or detatch to a session

```
tmux detatch

tmux attatch
# or
tmux a

tmux a -t <session-name>
```

### While on tmux,

press `prefix-s` to list out all the Session
press `prefix-w` to list out all the Windows
