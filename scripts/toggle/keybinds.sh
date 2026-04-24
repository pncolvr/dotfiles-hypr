#!/usr/bin/env bash

title="Keybinds"
address=$(hyprctl clients -j | jq -r \
    --arg title "$title" \
    '.[] | select(.class=="yad" and (.title | startswith($title))) | .address')

if [[ -n "$address" ]]; then
    hyprctl dispatch closewindow address:"$address"
else
    $HOME/.config/hypr/scripts/keybinds/display.sh --keybinds
fi