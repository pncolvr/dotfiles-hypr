#!/usr/bin/env bash

on=$(hyprctl -j getoption animations:enabled | jq --raw-output '.int')
if [[ $on -eq 1 ]]; then
    hyprctl keyword animations:enabled 0
    hyprctl notify -1 1000 "rgb(FE8D59)" "Animations off"
else
    hyprctl keyword animations:enabled 1
    hyprctl notify -1 1000 "rgb(2E7D32)" "Animations on"
fi