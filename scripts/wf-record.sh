#!/bin/sh

pgrep -x "wf-recorder" && pkill -INT -x wf-recorder && exit 0

framerate=30
dateTime=$(date +%m-%d-%Y-%H:%M:%S)
wf-recorder --framerate $framerate -f "$HOME/Videos/$dateTime".mp4
