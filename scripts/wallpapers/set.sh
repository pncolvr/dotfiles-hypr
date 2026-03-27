#!/usr/bin/env bash

monitor="$1"
shift
path="$*"

case $monitor in 
    1)m=DP-1;;
    2)m=HDMI-A-1;;
    *)echo "not supported"exit 1
esac

target="$HOME/Pictures/runtime/wallpaper$monitor"

ln -sf "$path" "$target"

swww img "$target" --outputs "$m" --transition-type any --transition-duration 1