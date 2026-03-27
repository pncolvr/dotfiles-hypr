#!/usr/bin/env bash

WORKSPACE=$(echo "$0" | xargs realpath | xargs dirname | xargs dirname)
source "$WORKSPACE"/_common/utils.sh

source "$(get_env_file "$0")"
TMP_FILE="$(get_temp_file_named streamdeck_last_page)"
# set the following variables on the .env file for the stream deck serial number you want
# SERIAL_NUMBER=

function change_page() {
    local page="$1"
    if [[ -f "$TMP_FILE" ]] && [[ "$(cat "$TMP_FILE")" == "$page" ]]; then
        return
    fi
    echo "$page" > "$TMP_FILE"
    streamcontroller -b --change-page $SERIAL_NUMBER "$page" > /dev/null 2>&1 & disown
}

if hyprctl activewindow | grep 'initialClass: com.core447.StreamController' > /dev/null 2>&1 && pgrep mpv > /dev/null 2>&1; then
    exit 0
fi

class=$(hyprctl activewindow -j | jq -r '.initialClass')

case $class in 
    *qutebrowser*|vivaldi-stable) change_page vivaldi;;
    mpv*) change_page mpv;;
    code) change_page code;;
    teams-for-linux) change_page teams;;
    *) change_page index;;
esac

