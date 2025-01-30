#!/bin/sh

time_stamp=$(date +"%d%m%y-%H%M%S%3N")

path="$HOME/Videos/Screencasts"
file="scrcpy-$time_stamp.mkv"
record_format="mkv"

vid_bitrate="8M"
max_fps="60"
max_size="2400" # in px
audio_codec="aac"

# Parse command line options
while getopts "b:" opt; do
  case $opt in
  b) vid_bitrate="$OPTARG" ;; # TODO: Typesafe this argument.
  \?)
    echo "Invalid option: $OPTARG" >&2
    exit 1
    ;;
  esac
done

echo "Bitrate: $vid_bitrate"

scrcpy \
  --record="$path/$file" \
  --record-format="$record_format" \
  --max-fps "$max_fps" \
  --max-size "$max_size" \
  --print-fps \
  --audio-dup \
  --video-bit-rate "$vid_bitrate" \
  --audio-codec "$audio_codec"

# Print warning message in black text on yellow background
printf "\e[43;30m WARN: make -b argument typesafe. \e[0m\n"

printf '%.s─' $(seq 1 "${COLUMNS:-$(tput cols)}")
echo

# Print video bitrate in green and bold
printf "\033[1;32mVideo saved: %s\033[0m\n" "$path/$file"
