#!/usr/bin/env bash

IFS='|' read text <<< "$(yad --title "qrencode" --form --field="Text")"
if [[ -n "$text" ]]; then 
    qrencode -o - "$text" | wl-copy & disown
    notify-send --expire-time=2000 "QRCode copied to clipboard" --transient
fi