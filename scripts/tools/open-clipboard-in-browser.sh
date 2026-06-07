#!/usr/bin/env bash

DEFAULT_BROWSER="$ZDOTDIR/scripts/default-browser/default-browser.sh"

url=$(wl-paste --no-newline)
# if [[ -z "$url" ]]; then
#     notify-send --urgency low "clipboard is empty" --transient
#     exit 1
# fi

"$DEFAULT_BROWSER" "$url"
