#!/usr/bin/env bash
WORKSPACE=$(dirname "${BASH_SOURCE[0]:-0}")

function show_keybinds() {
    local title="${1:-Keybinds}"
    local submap="${2:-}"

    # Field layout per line (tab-separated):
    #   1: pretty display column  2: raw key combo  3: raw action
    local items
    items=$("$WORKSPACE/parser.sh" "$submap" | awk -F';' '
        {
            key[NR] = $1
            act[NR] = $2
            if (length($1) > max) max = length($1)
        }
        END {
            for (i = 1; i <= NR; i++)
                printf "\033[1;36m%-*s\033[0m   %s\t%s\t%s\n", \
                    max, key[i], act[i], key[i], act[i]
        }
    ')

    printf "%s\n" "$items" | \
    fzf \
        --prompt="$title > " \
        --delimiter=$'\t' \
        --with-nth=1 \
        --layout=reverse \
        --height=100% \
        --border \
        --info=inline \
        --ansi \
        --preview 'echo -e "\033[1mKey:\033[0m    {2}\n\033[1mAction:\033[0m {3}"' \
        --preview-window=down:3:wrap \
        --bind "enter:execute-silent(echo {3} | wl-copy)+abort"
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
