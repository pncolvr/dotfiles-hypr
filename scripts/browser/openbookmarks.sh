#!/usr/bin/env bash

TEMP_DIR="${XDG_RUNTIME_DIR:-${TMPDIR:-/tmp}}"

function isRunning() {
    procInfo=$(hyprctl clients -j | jq -r --arg app "org.qutebrowser.qutebrowser" '.[] | select(.class == $app) | .pid')
    if [[ -z "$procInfo" ]]; then
        echo false
    else 
        echo true
    fi
}

if [[ "$(isRunning)" == true ]]; then
    # shellcheck source=/home/pncolvr/Projects/scripts/rofi/web/common/utils.sh
    source "$HOME"/Projects/scripts/rofi/web/common/utils.sh

    declare -A bookmarks

    while read -r url name; do
        #shellcheck disable=2034
        bookmarks["$name"]="$url"
    done < "$HOME"/.config/qutebrowser/bookmarks/urls

    bookmarksFile="$TEMP_DIR/qutebrowser_bookmarks"
    save_assoc_array "bookmarks" "$bookmarksFile"

    "$HOME"/Projects/scripts/rofi/web/common/handle.sh "$bookmarksFile" "open/search" "default" true
else
    qutebrowser & disown
fi
