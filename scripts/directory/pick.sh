#!/usr/bin/env bash

WORKSPACE=$(echo "${BASH_SOURCE[0]:-0}" | xargs realpath | xargs dirname | xargs dirname)
source "$WORKSPACE"/_common/utils.sh

FILE=$(get_env_file "${BASH_SOURCE[0]:-0}")
STATUS=$($ZDOTDIR/scripts/status/manager.sh --check)

if [[ "$STATUS" == "work" ]]; then
    TEMP_FILE=$(get_temp_file_named "pick_combined")
    jq '{
        prompt,
        action,
        allowTyped,
        sort,
        items: (.items + (.extraItems // []))
    }' "$FILE" > "$TEMP_FILE"
    FILE="$TEMP_FILE"
fi

chosen=$("$HOME"/.config/rofi/scripts/_common/handle.sh "$FILE")

if [[ -n $chosen ]]; then 
    open_file_explorer $(realpath "$chosen")
fi
