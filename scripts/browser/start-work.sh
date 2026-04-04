#!/usr/bin/env bash

workspaceAlreadyExists=$(hyprctl workspaces | grep "workspace ID 9")
hyprctl dispatch workspace 9
if [ -z "$workspaceAlreadyExists" ]; then
    "$ZDOTDIR"/scripts/default-browser/default-browser.sh https://www.monday.com & disown
fi