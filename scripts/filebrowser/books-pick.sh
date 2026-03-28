#!/usr/bin/env bash

# shellcheck source=$HOME/Projects/scripts/rofi/web/common/utils.sh
source "$HOME"/Projects/scripts/rofi/web/common/utils.sh

get_title() {
    local file="$1"
    local filename
    local ext
    ext="${file##*.}"
    ext="${ext,,}"
    local title=""
    if [[ "$ext" == "pdf" ]]; then
        title=$(pdfinfo "$file" 2>/dev/null | sed -n 's/^Title:[[:space:]]*//p' | head -n1)
    elif [[ "$ext" == "epub" ]]; then
        title=$(exiftool -Title "$file" 2>/dev/null | sed -n 's/^Title[[:space:]]*:[[:space:]]*//p' | head -n1)
    fi
    title=$(echo "$title" | sed 's/^ *//;s/ *$//;s/  */ /g')
    if [[ -z "$title" ]]; then
        filename="${file##*/}"
        title="${filename%.*}"
    fi
    title="${title} (${ext})"
    echo "$title"
}

build_cache() {
    echo "Building cache..."
    mapfile -t files < <(find "$HOME/Books" -type f \( -iname '*.pdf' -o -iname '*.epub' \))
    declare -A books
    for file in "${files[@]}"; do
        title=$(get_title "$file")
        echo "Found file '$file' with title: '$title'"
        books["$title"]="$file"
    done
    save_assoc_array "books" "$user_tmp"
    echo "Cache saved: $user_tmp"
}

user_tmp="${XDG_CACHE_HOME:-$HOME/.cache}/books_${USER}"

rebuild_cache=false
pick=false
for arg in "$@"; do
    case "$arg" in
        --rebuild-cache)
            rebuild_cache=true
            ;;
        --pick)
            pick=true
            ;;
    esac
done

if $rebuild_cache; then
    build_cache
fi

if $pick; then
    # If cache file doesn't exist, build it first
    if [[ ! -f "$user_tmp" ]]; then
        build_cache
    fi
    
    file="$user_tmp"
    chosen=$("$HOME"/Projects/scripts/rofi/web/common/handle.sh "$file" "open" output)
    if [[ -n $chosen ]]; then
        zathura "$chosen" &
    fi
fi