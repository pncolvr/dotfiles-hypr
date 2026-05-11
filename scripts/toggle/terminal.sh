#!/usr/bin/env bash
source $HOME/.config/hypr/scripts/_common/utils.sh

CLASS="com.mitchellh.ghostty"
TITLE="dropdown-term"
ACTIVE_WORKSPACE=$(hyprctl activeworkspace -j)

# to check window already exists
WINDOW_ADDRESS=$(hyprctl clients -j | jq -r --arg class_name $CLASS --arg title $TITLE '[.[] | select(.class==$class_name and .title==$title)] | .[0].address // ""')
# WINDOW_ADDRESS=$(hyprctl clients -j | jq -r --arg class_name $CLASS --arg title $TITLE '[.[] | select(.class==$class_name and .title==$title)] | .[0].address // "" | ltrimstr("0x")')
echo $WINDOW_ADDRESS
if [[ -n "$WINDOW_ADDRESS" ]]; then
    hyprctl dispatch 'hl.dsp.window.close({ window = "address:'$WINDOW_ADDRESS'"})'
else
    ghostty --title="$TITLE" > /dev/null 2>&1 & disown 
    move_cursor_to_position "$ACTIVE_WORKSPACE" "0.5" "0.25"
fi
