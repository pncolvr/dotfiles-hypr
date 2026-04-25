#!/usr/bin/env bash
WORKSPACE=$(dirname "${BASH_SOURCE[0]:-0}")

SCRIPT_PARAMS="$*"

function get_items() {
    local submap="$1"
    if [[ -n "$submap" ]]; then
        mapfile -t lines < <("$WORKSPACE/submap/parser.sh" "$submap")
    else
        mapfile -t lines < <("$WORKSPACE/parser.sh")
    fi

    printf '%s\n' "${lines[@]}"
}

function show_submap() {
    local submap="$1"
    local items=()
    local title rows height max_height screen_height results
    local line key action

    while IFS=';' read -r key action; do
        items+=( "$key" "$action" )
    done <  <(get_items "$submap")

    title="Submap: $submap"

    rows=$(( ${#items[@]} / 2 ))
    screen_height=$(hyprctl monitors -j | jq '.[] | select(.focused==true) | .height')

    height=$(( 20 + 25 * rows ))
    max_height=$(( screen_height - 50 ))

    (( height > max_height )) && height=$max_height

    show_yad_list "$title" 300 "$height" "${items[@]}"
}

function show_keybinds() {
    local title screen_height
    ensure_inside_terminal
    mapfile -t results < <(get_items)

    title="Keybinds"

    screen_height=$(hyprctl monitors -j | jq '.[] | select(.focused==true) | .height')
    items=$( printf "%s\n" "${results[@]}" | sed 's/;/\t/')
    show_fzf_keybinds "$title" "${items[@]}"
}

function ensure_inside_terminal() {
    if [[ -z "$FZF_LAUNCHER" ]]; then
        exec ghostty --title=Keybinds \
            -e bash -c "FZF_LAUNCHER=1 $0 $SCRIPT_PARAMS"
    fi
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
        --no-headers \
        --no-selection \
        --undecorated \
        --width="$width" \
        --height="$height" \
        --timeout=0 \
        "${items[@]}" & disown
}

function show_fzf_keybinds() {
    local title="$1"
    shift 1

    printf "%s\n" "$@" | \
    fzf \
        --prompt="$title > " \
        --delimiter=$'\t' \
        --with-nth=1,2 \
        --layout=reverse \
        --height=100% \
        --border \
        --info=inline \
        --ansi \
        --preview 'echo -e "\033[1mKey:\033[0m {1}\n\033[1mAction:\033[0m {2}"' \
        --preview-window=down:3:wrap \
        --bind "enter:execute-silent(echo {2} | wl-copy)+abort"
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

