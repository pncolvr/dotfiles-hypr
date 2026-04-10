#!/usr/bin/env bash

text=$(yad --title "qrencode" --form --field="Text")
text="${text::-1}"
if [[ -n "$text" ]]; then 
    qrencode -o - "$text" | wl-copy & disown
    notify-send --expire-time=2000 "QRCode copied to clipboard" --transient
fi