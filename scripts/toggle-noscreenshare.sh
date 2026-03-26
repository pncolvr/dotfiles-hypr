#!/usr/bin/env bash

current=$(hyprctl getprop activewindow no_screen_share 2>/dev/null)
new_status=$([[ "$current" == "false" ]] && echo 1 || echo 0)
hyprctl dispatch setprop activewindow no_screen_share "$new_status" >/dev/null 2>&1
pkill -RTMIN+1 waybar