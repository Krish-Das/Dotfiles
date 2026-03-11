#!/usr/bin/env sh

notify-send -r 4242 -a "Clock" "$(date +'%H:%M %p')" "$(date +'%a, %d %b')" -t 1500
