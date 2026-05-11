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
    *) exit;;
esac

code --new-window "$FILE"
TITLE=$(basename "$FILE")
WINDOW_ADDRESS=$(wait_for_window "$CLASS")




if [[ -n "$WINDOW_ADDRESS" ]]; then
    read mon_w mon_h < <(hyprctl -j monitors | jq -r '.[] | select(.focused) | "\(.width) \(.height)"')
    resize_x=$(( mon_w * 25 / 100 ))
    resize_y=$(( mon_h * 66 / 100 ))
    move_x=$(( mon_w * 74 / 100 ))
    move_y=$(( mon_h * 14 / 100 ))

    hyprctl eval "
    local w = 'address:$WINDOW_ADDRESS'
        hl.dispatch(hl.dsp.window.move({ out_of_group = true, window = w }))
        hl.dispatch(hl.dsp.window.float({ action = 'enable', window = w }))
        hl.dispatch(hl.dsp.window.resize({ x = $resize_x, y = $resize_y, window = w }))
        hl.dispatch(hl.dsp.window.move({ x = $move_x, y = $move_y, window = w }))
        hl.dispatch(hl.dsp.window.move({ workspace = $WORKSPACE_ID, window = w }))
        hl.dispatch(hl.dsp.window.pin({ window = w }))
    " > >(log) 2> >(log_error) 2>&1
    move_cursor_to_position "$ACTIVE_WORKSPACE" "0.865" "0.47"
fi
