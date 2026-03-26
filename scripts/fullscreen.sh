#!/usr/bin/env bash

hyprctl dispatch fullscreen "$1" >/dev/null 2>&1
pkill -RTMIN+1 waybar