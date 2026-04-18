#!/usr/bin/env bash
SCRIPT_DIR=$(dirname "${BASH_SOURCE[0]:-0}")
WORKSPACE=$(cd -- "$SCRIPT_DIR/.." && pwd)
source "$WORKSPACE"/_common/utils.sh

IFS='|' read text <<< "$(yad --title "qrencode" --form --field="Text")"
if [[ -n "$text" ]]; then 
    qrencode -o - "$text" | wl-copy & disown
    notify "QRCode copied to clipboard"
fi