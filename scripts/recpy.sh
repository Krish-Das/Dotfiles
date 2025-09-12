#!/bin/sh
set -e

time_stamp=$(date +"%d%m%y_%H%M%S%3N")
path="$HOME/Videos/Screencasts"
given_name=""
record_format="mkv"
vid_bitrate="8M"
max_fps="60"
max_size="2400" # in px
show_touch=false
# audio_codec="aac"

# Parse command line options
while getopts "n:b:t" opt; do
  case $opt in
  n) given_name="$OPTARG" ;;
  b) vid_bitrate="$OPTARG" ;;
  t) show_touch=true ;;
  \?)
    echo "Invalid option: $OPTARG" >&2
    echo "Usage: $0 [-n name] [-b bitrate] [-t]"
    echo "  -n: Set custom name for output file"
    echo "  -b: Set video bitrate (default: 8M)"
    echo "  -t: Enable touch display"
    exit 1
    ;;
  esac
done

# Ensure output directory exists
# mkdir -p "$OUTPUT_DIR"

echo "Bitrate: $vid_bitrate"
echo "Show touch: $show_touch"

if [ -n "$given_name" ]; then
  file="$given_name-$time_stamp.mkv"
else
  file="scrcpy-$time_stamp.mkv"
fi

# Build scrcpy command with conditional touch option
scrcpy_cmd="scrcpy \
  --record=\"$path/$file\" \
  --record-format=\"$record_format\" \
  --max-fps \"$max_fps\" \
  --max-size \"$max_size\" \
  --print-fps \
  --video-bit-rate \"$vid_bitrate\" \
  --audio-dup"
# --audio-codec "$audio_codec"

if [ "$show_touch" = true ]; then
  scrcpy_cmd="$scrcpy_cmd --show-touch"
fi

# Execute the command
eval "$scrcpy_cmd"

# Print warning message in black text on yellow background
printf '%.s─' $(seq 1 "${COLUMNS:-$(tput cols)}")
echo
# Print video bitrate in green and bold
printf "\033[1;32mVideo saved: %s\033[0m\n" "$path/$file"
