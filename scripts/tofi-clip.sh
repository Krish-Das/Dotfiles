#!/bin/sh

# clipboard manager using tofi
# requires tofi, cliphist and wl-clipboard to function

text=$(cliphist list | tofi -c "$HOME/.config/tofi/clip-config")
[ -n "$text" ] && cliphist decode <<< "$text" | wl-copy
