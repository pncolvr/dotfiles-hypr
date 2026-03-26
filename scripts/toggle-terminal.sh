#!/usr/bin/env bash

CLASS="kitty-dropdown"
# to check window already exists
address=$(hyprctl clients -j | jq -r --arg class_name $CLASS '[.[] | select(.class==$class_name)] | .[0].address // ""')
if [[ "$address" ]]; then
    hyprctl dispatch closewindow class:$CLASS
else
    kitty --class "$CLASS"
fi