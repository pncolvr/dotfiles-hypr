#!/usr/bin/env bash

WORKSPACE=$(echo "$0" | xargs realpath | xargs dirname)
source "$WORKSPACE"/_common/utils.sh

function is_running() {
    procInfo=$(hyprctl clients -j | jq -r --arg app "org.qutebrowser.qutebrowser" '.[] | select(.class == $app) | .pid')
    if [[ -z "$procInfo" ]]; then
        echo false
    else 
        echo true
    fi
}

if [[ "$(is_running)" == true ]]; then
    
    source "$HOME"/.config/rofi/scripts/_common/utils.sh

    declare -A bookmarks

    while read -r url name; do
        #shellcheck disable=2034
        bookmarks["$name"]="$url"
    done < "$HOME"/.config/qutebrowser/bookmarks/urls

    bookmarksFile=$(get_temp_file_named "qutebrowser_bookmarks")
    save_assoc_array "bookmarks" "$bookmarksFile"

    "$HOME"/.config/rofi/scripts/_common/handle.sh "$bookmarksFile" "open/search" "default" true
else
    qutebrowser & disown
fi
