#!/usr/bin/env bash

monitor="$1"
status="$2"
shift 2
path="$*"

case $monitor in 
    1)m=DP-1;;
    2)m=HDMI-A-1;;
    *)echo "not supported" && exit 1;;
esac

target="$HOME/Pictures/.runtime/wallpaper_${status}_$monitor"

ln -sf "$path" "$target"

awww img "$target" --outputs "$m" --transition-type any --transition-duration 2