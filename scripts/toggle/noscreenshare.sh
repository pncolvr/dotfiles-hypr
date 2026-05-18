#!/usr/bin/env bash

current=$(hyprctl getprop activewindow no_screen_share 2>/dev/null)
new_status=$([[ "$current" == "false" ]] && echo true || echo false)

hyprctl dispatch 'hl.dsp.window.set_prop({ prop = "no_screen_share", value = "'$new_status'" })'

qs ipc call windows reload