#!/usr/bin/env bash
WORKSPACE=$(echo "${BASH_SOURCE[0]:-0}" | xargs realpath | xargs dirname)
source "$WORKSPACE"/_common/utils.sh

ACTIVE_WORKSPACE=$(hyprctl activeworkspace -j)
WORKSPACE_ID=$(echo "$ACTIVE_WORKSPACE" | jq -r '.id')
CLASS="code"

RAND_NAME="$CLASS-temp-$(date +%s)-$RANDOM"
FILE="$(get_temp_file_named "$RAND_NAME")"

code --new-window "$FILE"

WINDOW_ADDRESS=$(wait_for_window "$CLASS" "$RAND_NAME")
CURSOR_POSITION=$(calculate_cursor_move_to_position "$ACTIVE_WORKSPACE" "0.865" "0.47")

if [[ -n "$WINDOW_ADDRESS" ]]; then
    hyprctl --batch \
        "dispatch moveoutofgroup address:$WINDOW_ADDRESS ; \
        dispatch togglefloating address:$WINDOW_ADDRESS ; \
        dispatch resizewindowpixel exact 25% 66%,address:$WINDOW_ADDRESS ; \
        dispatch movewindowpixel exact 74% 14%,address:$WINDOW_ADDRESS ; \
        dispatch movetoworkspace $WORKSPACE_ID,address:$WINDOW_ADDRESS ; \
        dispatch pin address:$WINDOW_ADDRESS ; \
        dispatch movecursor $CURSOR_POSITION" \
        > /dev/null 2>&1
fi
