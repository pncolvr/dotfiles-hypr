#!/usr/bin/env bash
workspace=$(dirname "${BASH_SOURCE[0]:-0}")
folder="$1"
find_cmd=(
    find "$folder" -type f \( \
        -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' -o \
        -iname '*.webp' -o -iname '*.bmp' -o -iname '*.gif' -o \
        -iname '*.tiff' \)
)


while true; do
    selected="$("${find_cmd[@]}" | \
        fzf --prompt="(Alt+1/2 to set wallpaper) > " \
            --preview "bash $workspace/fzf-preview.sh {}" \
            --layout=reverse \
            --preview-window=right,50%,wrap \
            --bind "alt-1:execute-silent(bash '$workspace/set.sh' 1 personal '{}')" \
            --bind "alt-2:execute-silent(bash '$workspace/set.sh' 1 work '{}')" \
            --bind 'esc:abort' \
            --bind 'ctrl-c:abort')"

    [ -z "$selected" ] && break
done

kitty +kitten icat --clear
