#!/usr/bin/env bash

on=$(hyprctl -j getoption animations:enabled | jq -r '.bool')
if [[ $on == "true" ]]; then
    # hyprctl eval 'hl.config.set("animations.enabled", false)'
    hyprctl eval 'hl.config({animations = { enabled = false}})'
    hyprctl notify -1 1000 "rgb(FE8D59)" "Animations off"
else
    hyprctl eval 'hl.config({animations = { enabled = true}})'
    hyprctl notify -1 1000 "rgb(2E7D32)" "Animations on"
fi
