#!/usr/bin/env bash
WORKSPACE=$(dirname "${BASH_SOURCE[0]:-0}")

function get_items() {
    local submap="$1"
    if [[ -n "$submap" ]]; then
        mapfile -t lines < <("$WORKSPACE/submap/parser.sh" "$submap")
    else
        mapfile -t lines < <("$WORKSPACE/parser.sh")
    fi

    local items=()
    local line key action

    for line in "${lines[@]}"; do
        IFS=';' read -r key action <<< "$line"
        [[ -z "$key" ]] && continue
        items+=( "$key" "$action" )
    done

    printf '%s\n' "${items[@]}"
}

function show_submap() {
    local submap="$1"
    local items
    local title rows height max_height screen_height

    mapfile -t items < <(get_items "$submap")

    title=$(yad_title "$submap")

    rows=$(( ${#items[@]} / 2 ))
    screen_height=$(hyprctl monitors -j | jq '.[] | select(.focused==true) | .height')

    height=$(( 45 + 25 * rows ))
    max_height=$(( screen_height - 50 ))

    (( height > max_height )) && height=$max_height

    show_yad_list "$title" 300 "$height" "${items[@]}"
}

function show_keybinds() {
    local items
    local title screen_height

    mapfile -t items < <(get_items)

    title="Keybinds"

    screen_height=$(hyprctl monitors -j | jq '.[] | select(.focused==true) | .height')

    show_yad_list "$title" 800 $(( screen_height - 400 )) "${items[@]}"
}

function show_yad_list() {
    local title="$1"
    local width="$2"
    local height="$3"
    shift 3
    local items=("$@")

    yad --list \
        --title="$title" \
        --column="Key" \
        --column="Action" \
        --no-buttons \
        --undecorated \
        --width="$width" \
        --height="$height" \
        --timeout=0 \
        "${items[@]}" & disown
}

function yad_title() {
    local submap="$1"
    echo -n "Submap: $submap"
}

function usage () {
    echo "Usage: $0 [command] [argument]"
    echo ""
    echo "Commands:"
    echo "  $0 --submap 'submap name' Shows the keybinds of a specific submap."
    echo "  $0 --keybinds             Lists all keybinds, not submap ones."
    echo "  $0 --help                 Show this usage message."
}

case $1 in 
    --submap) 
        if [[ $# -ne 2 ]]; then
            echo "Error: --submap requires a submap name."
            exit 1
        fi
        show_submap "$2";;
    --keybinds) show_keybinds;;
    --help)
        usage
        ;;
    *)
        usage
        exit 1
esac

