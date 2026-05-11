#!/usr/bin/env bash


case $1 in
    --more)  hyprctl eval "hl.config({ cursor = { zoom_factor = $(hyprctl -j getoption cursor:zoom_factor | jq '.float * 1.1') } })";;
    --less)  hyprctl eval "hl.config({ cursor = { zoom_factor = $(hyprctl -j getoption cursor:zoom_factor | jq '(.float * 0.9) | if . < 1 then 1 else . end') } })";;
    --reset) hyprctl eval 'hl.config({ cursor = { zoom_factor = 1 } })';;
esac