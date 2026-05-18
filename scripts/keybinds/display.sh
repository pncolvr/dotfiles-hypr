#!/usr/bin/env bash
WORKSPACE=$(dirname "${BASH_SOURCE[0]:-0}")

# SCRIPT_PARAMS="$*"

function get_items() {
    mapfile -t lines < <("$WORKSPACE/keybinds.sh")
    printf '%s\n' "${lines[@]}"
}

function show_keybinds() {
    local title screen_height
    # ensure_inside_terminal
    mapfile -t results < <(get_items)

    title="Keybinds"

    items=$(printf "%s\n" "${results[@]}" | sed 's/;/\t/')
    show_fzf_keybinds "$title" "${items[@]}"
}

# function ensure_inside_terminal() {
#     if [[ -z "$FZF_LAUNCHER" ]]; then
#         exec ghostty --title=Keybinds \
#             -e bash -c "FZF_LAUNCHER=1 $0 $SCRIPT_PARAMS"
#     fi
# }

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
    echo "  $0 --keybinds             Lists all keybinds, not submap ones."
    echo "  $0 --help                 Show this usage message."
}

case $1 in 
    --keybinds) 
        show_keybinds;;
    --help)
        usage
        ;;
    *)
        usage
        exit 1
esac

