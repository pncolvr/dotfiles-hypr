#!/usr/bin/env bash

WORKSPACE=$(echo "${BASH_SOURCE[0]:-0}" | xargs realpath | xargs dirname | xargs dirname)
source "$WORKSPACE"/_common/utils.sh

TEMPLATE_JSON='{
    "prompt": "",
    "action": "default",
    "allowTyped": true,
    "allowMultipleSelection": true,
    "sort": true
}'

json_items=()
while read -r url name; do
    json_items+=("$(jq -cn --arg title "$name" --arg result "$url" '{title: $title, result: $result}')")
done < "$HOME"/.config/qutebrowser/bookmarks/urls

items_json=$(printf '%s\n' "${json_items[@]}" | jq -s '.')
final_json=$(jq -n --argjson items "$items_json" --argjson template "$TEMPLATE_JSON" '$template + {items: $items}')

bookmarks_file=$(get_temp_file_named "qutebrowser_bookmarks")
echo "$final_json" > "$bookmarks_file"

"$HOME"/.config/rofi/scripts/_common/handle.sh "$bookmarks_file"