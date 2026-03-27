#!/usr/bin/env bash

swww query || swww-daemon

# Define wallpapers per monitor
swww img ~/Pictures/runtime/wallpaper1 --outputs DP-1
swww img ~/Pictures/runtime/wallpaper2 --outputs HDMI-A-1

