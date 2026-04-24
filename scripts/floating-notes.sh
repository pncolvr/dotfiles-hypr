#!/usr/bin/env bash
WORKSPACE=$(dirname "${BASH_SOURCE[0]:-0}")

source "$WORKSPACE"/_common/utils.sh
source $(get_env_file "${BASH_SOURCE[0]:-0}")
# creaet env file with:
# NOTES_WORK_PATH=
# NOTES_PERSONAL_PATH=

ACTIVE_WORKSPACE=$(hyprctl activeworkspace -j)
WORKSPACE_ID=$(echo "$ACTIVE_WORKSPACE" | jq -r '.id')
CLASS="code"

case "$1" in
    random)
        FILE=$(get_temp_file_named "$CLASS-temp-$(date +%s)-$RANDOM");;
    work)
        FILE=$NOTES_WORK_PATH;;
    personal)
        FILE=$NOTES_PERSONAL_PATH;;
esac

code --new-window "$FILE"
TITLE=$(basename "$FILE")
WINDOW_ADDRESS=$(wait_for_window "$CLASS")

if [[ -n "$WINDOW_ADDRESS" ]]; then
    CURSOR_POSITION=$(calculate_cursor_move_to_position "$ACTIVE_WORKSPACE" "0.865" "0.47")
    hyprctl --batch \
        "dispatch moveoutofgroup address:$WINDOW_ADDRESS ; \
        dispatch togglefloating address:$WINDOW_ADDRESS ; \
        dispatch resizewindowpixel exact 25% 66%,address:$WINDOW_ADDRESS ; \
        dispatch movewindowpixel exact 74% 14%,address:$WINDOW_ADDRESS ; \
        dispatch movetoworkspace $WORKSPACE_ID,address:$WINDOW_ADDRESS ; \
        dispatch pin address:$WINDOW_ADDRESS ; \
        dispatch movecursor $CURSOR_POSITION" \
        > >(log) 2> >(log_error) 2>&1
fi
