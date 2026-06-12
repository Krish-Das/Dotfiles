#!/bin/sh
set -e

show_help() {
  cat <<EOF
Usage: $0 [OPTIONS]

Record Android screen using scrcpy.

OPTIONS:
  -n NAME      Set custom name for output file
  -b BITRATE   Set video bitrate (default: 8M)
  -t           Show physical touches (requires control)
  -h           Show this help message

EXAMPLES:
  $0 -n demo -b 10M -t
  $0 -n gameplay
EOF
}

render_driver="opengl"
time_stamp=$(date +"%d%m%y_%H%M%S%3N")
path="$HOME/Videos/Screencasts"
given_name=""
record_format="mkv"
vid_bitrate="8M"
max_fps="60"
max_size="2400"
show_touch=false

# Parse command line options
while getopts "n:b:th" opt; do
  case $opt in
  n) given_name="$OPTARG" ;;
  b) vid_bitrate="$OPTARG" ;;
  t) show_touch=true ;;
  h)
    show_help
    exit 0
    ;;
  \?)
    echo "Error: Invalid option -$OPTARG" >&2
    echo "Use -h for help" >&2
    exit 1
    ;;
  esac
done

echo "Bitrate: $vid_bitrate"
echo "Show touch: $show_touch"

if [ -n "$given_name" ]; then
  file="$given_name-$time_stamp.mkv"
else
  file="scrcpy-$time_stamp.mkv"
fi

# Build scrcpy command - add conditional flags inside the main string
if [ "$show_touch" = true ]; then
  control_flag="--show-touches"
else
  control_flag="--no-control"
fi

scrcpy_cmd="
scrcpy \
  --record=\"$path/$file\" \
  --record-format=\"$record_format\" \
  --max-fps \"$max_fps\" \
  --max-size \"$max_size\" \
  --print-fps \
  --video-bit-rate \"$vid_bitrate\" \
  --audio-dup \
  --no-playback \
  --render-driver=$render_driver \
  $control_flag
"

eval "$scrcpy_cmd"

printf '%.s─' $(seq 1 "${COLUMNS:-$(tput cols)}")
echo
printf "\033[1;32mVideo saved: %s\033[0m\n" "$path/$file"
