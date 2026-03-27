#!/usr/bin/env bash
workspace=$(echo "$0" | xargs realpath | xargs dirname)
folder="$1"
find_cmd=(
    find "$folder" -type f \( \
        -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' -o \
        -iname '*.webp' -o -iname '*.bmp' -o -iname '*.gif' -o \
        -iname '*.tiff' \)
)


while true; do
    selected="$("${find_cmd[@]}" | \
        fzf --prompt="Select image (Alt+1/2 to set wallpaper) > " \
            --preview "bash $workspace/fzf-preview.sh {}" \
            --preview-window=right,50%,wrap \
            --bind "alt-1:execute-silent('$workspace/set.sh' 1 '{}')" \
            --bind "alt-2:execute-silent('$workspace/set.sh' 2 '{}')" \
            --bind 'esc:abort' \
            --bind 'ctrl-c:abort')"

    [ -z "$selected" ] && break
done

kitty +kitten icat --clear
