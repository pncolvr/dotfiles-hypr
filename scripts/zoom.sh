#!/usr/bin/env bash


case $1 in 
    --more)  hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor -j | jq '.float * 1.1');;
    --less)  hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor -j | jq '(.float * 0.9) | if . < 1 then 1 else . end');;
    --reset) hyprctl -q keyword cursor:zoom_factor 1
esac
