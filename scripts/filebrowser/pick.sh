#!/usr/bin/env bash

WORKSPACE=$(echo "${BASH_SOURCE[0]:-0}" | xargs realpath | xargs dirname | xargs dirname)
source "$WORKSPACE"/_common/utils.sh

file=$(get_env_file "${BASH_SOURCE[0]:-0}")

if [[ $1 != "work" ]]; then
    temp_file=$(get_temp_file_named "pick_combined")
    jq '{
        prompt,
        action,
        allowTyped,
        sort,
        items: (.items + (.extraItems // []))
    }' "$file" > "$temp_file"
    file="$temp_file"
fi

chosen=$("$HOME"/.config/rofi/scripts/_common/handle.sh "$file")

if [[ -n $chosen ]]; then 
    open_file_explorer $(realpath "$chosen")
fi
