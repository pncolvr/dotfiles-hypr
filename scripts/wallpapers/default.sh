#!/usr/bin/env bash
mode=${1:personal}
awww query || awww-daemon

# Define wallpapers per monitor
awww img ~/Pictures/.runtime/wallpaper_${mode}_1 --outputs DP-1 --transition-type any --transition-duration 0.5
# currently not used, for later
# awww img ~/Pictures/runtime/wallpaper2 --outputs HDMI-A-1 --transition-type any --transition-duration 0.5

