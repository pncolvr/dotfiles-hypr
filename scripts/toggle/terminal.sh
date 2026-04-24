#!/usr/bin/env bash
source $HOME/.config/hypr/scripts/_common/utils.sh

CLASS="com.mitchellh.ghostty"
TITLE="dropdown-term"
ACTIVE_WORKSPACE=$(hyprctl activeworkspace -j)

# to check window already exists
WINDOW_ADDRESS=$(hyprctl clients -j | jq -r --arg class_name $CLASS --arg title $TITLE '[.[] | select(.class==$class_name and .title==$title)] | .[0].address // ""')
echo $WINDOW_ADDRESS
if [[ -n "$WINDOW_ADDRESS" ]]; then
    hyprctl dispatch closewindow address:"$WINDOW_ADDRESS"
else
    ghostty --title="$TITLE" & disown
    CURSOR_POSITION=$(calculate_cursor_move_to_position "$ACTIVE_WORKSPACE" "0.5" "0.8")
    hyprctl dispatch movecursor "$CURSOR_POSITION"
fi
