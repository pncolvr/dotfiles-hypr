#!/usr/bin/env bash
WORKSPACE=$(dirname "${BASH_SOURCE[0]:-0}")

function show() {
    local submap title height rows max_height screen_height
    submap="$1"
    mapfile -t lines < <("$WORKSPACE/parser.sh" "$submap")
    items=()

    for line in "${lines[@]}"; do
        IFS=';' read -r key action <<< "$line"
        [[ -z "$key" ]] && continue
        items+=( "$key" "$action" )
    done

    title=$(yad_title "$submap")
    rows=$(( ${#items[@]} / 2 ))
    screen_height=$(hyprctl monitors -j | jq '.[] | select(.focused==true) | .height')
    height=$(( 45 + 25 * rows ))
    max_height=$(( screen_height - 50 ))
    (( height > max_height )) && height=$max_height
    yad --list \
        --title="$title" \
        --column="Key" \
        --column="Action" \
        --no-buttons \
        --undecorated \
        --width=300 \
        --height=$height \
        --timeout=0 \
        "${items[@]}" & disown
}

function yad_title() {
    local submap="$1"
    echo -n "Submap: $submap"
}

show "$1"

