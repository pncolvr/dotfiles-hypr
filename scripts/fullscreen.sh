#!/usr/bin/env bash

window_json=$(hyprctl activewindow -j)
pinned=$(echo "$window_json" | jq -r '.pinned')

if [[ "$pinned" == "true" ]]; then
    hyprctl dispatch pin >/dev/null 2>&1
    notify-send "Window unpinned" "Unpinned active window before fullscreen."
fi

hyprctl dispatch fullscreen "$1" >/dev/null 2>&1
pkill -RTMIN+1 waybar >/dev/null 2>&1