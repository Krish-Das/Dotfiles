#!/bin/sh

# Power menu script using tofi

CHOSEN=$(printf "Do nothing\nReboot\nShutdown\nQuit Hyprland" | tofi --config "$HOME"/.config/tofi/powermenu-config)

case "$CHOSEN" in
	"Reboot")
		ACTION="reboot"
		PROMPT_TEXT="󰜉"
		;;
	"Shutdown")
		ACTION="poweroff"
		PROMPT_TEXT=""
		;;
	"Quit Hyprland")
		ACTION="hyprctl dispatch exit"
		PROMPT_TEXT=""
		;;
	*)
		exit 1
		;;
esac

CONFIRM=$(printf "No\nYes" | tofi --prompt-text="$PROMPT_TEXT" --config "$HOME"/.config/tofi/powermenu-config)
[ "$CONFIRM" = "Yes" ] && $ACTION
