#!/bin/sh
set -e

show_help() {
  cat <<EOF
Usage: $0 [OPTIONS]

Record Android screen using scrcpy.

OPTIONS:
  -n NAME      Set custom name for output file
  -b BITRATE   Set video bitrate (default: 8M)
  -c CODEC     Set video codec: h264, h265 (default: h265)
  -t           Show physical touches (requires control)
  -s           Silent mode: disable audio recording
  -h           Show this help message

EXAMPLES:
  $0 -n demo -b 10M -t
  $0 -n gameplay -c h265
  $0 -n silent -s
EOF
}

render_driver="opengl"
time_stamp=$(date +"%d%m%y_%H%M%S%3N")
path="$HOME/Videos/Screencasts"
given_name=""
record_format="mkv"
vid_bitrate="8M"
vid_codec="h264"
max_fps="60"
max_size="2400"
show_touch=false
no_audio=false

# Parse command line options
while getopts "n:b:c:tsh" opt; do
  case $opt in
  n) given_name="$OPTARG" ;;
  b) vid_bitrate="$OPTARG" ;;
  c) vid_codec="$OPTARG" ;;
  t) show_touch=true ;;
  s) no_audio=true ;;
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
echo "Codec: $vid_codec"
echo "Show touch: $show_touch"
echo "No audio: $no_audio"

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

if [ "$no_audio" = true ]; then
  audio_flag="--no-audio"
else
  audio_flag=""
fi

scrcpy_cmd="
scrcpy \
  --record=\"$path/$file\" \
  --record-format=\"$record_format\" \
  --video-codec=\"$vid_codec\" \
  --max-fps \"$max_fps\" \
  --max-size \"$max_size\" \
  --no-video-playback \
  --print-fps \
  --video-bit-rate \"$vid_bitrate\" \
  $control_flag \
  $audio_flag
"

eval "$scrcpy_cmd"

printf '%.s─' $(seq 1 "${COLUMNS:-$(tput cols)}")
echo
printf "\033[1;32mVideo saved: %s\033[0m\n" "$path/$file"
