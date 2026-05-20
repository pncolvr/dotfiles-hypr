#!/usr/bin/env bash
WORKSPACE=$(dirname "${BASH_SOURCE[0]:-0}")

function show_keybinds() {
    local title="${1:-Keybinds}"
    local submap="${2:-}"

    local items
    items=$("$WORKSPACE/parser.sh" "$submap" | sed 's/;/\t/')

    printf "%s\n" "$items" | \
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
    echo "  $0 --keybinds             List global keybinds."
    echo "  $0 --submap <name>        List keybinds for a submap."
    echo "  $0 --help                 Show this usage message."
}

case $1 in
    --keybinds)
        show_keybinds "Keybinds" "";;
    --submap)
        show_keybinds "Submap: $2" "$2";;
    --help)
        usage;;
    *)
        usage
        exit 1
esac
