#!/usr/bin/env sh

pgrep -x "wf-recorder" && pkill -INT -x wf-recorder && exit 0

framerate=25
dateTime=$(date +%m-%d-%Y-%H:%M:%S)
wf-recorder --bframes $framerate -f "$HOME/Videos/$dateTime".mp4
