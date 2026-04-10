#!/usr/bin/env bash

WORKSPACE=$(dirname "$(dirname "${BASH_SOURCE[0]:-0}")")

source "$WORKSPACE"/_common/utils.sh

CLASS="kitty-dropdown"
ACTIVE_WORKSPACE=$(hyprctl activeworkspace -j)

# to check window already exists
WINDOW_ADDRESS=$(hyprctl clients -j | jq -r --arg class_name $CLASS '[.[] | select(.class==$class_name)] | .[0].address // ""')
if [[ "$WINDOW_ADDRESS" ]]; then
    hyprctl dispatch closewindow class:$CLASS
else
    kitty --class "$CLASS" & disown
    CURSOR_POSITION=$(calculate_cursor_move_to_position "$ACTIVE_WORKSPACE" "0.5" "0.8")
    hyprctl dispatch movecursor "$CURSOR_POSITION"
fi