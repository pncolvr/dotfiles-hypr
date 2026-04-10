#!/usr/bin/env bash

hyprctl dispatch pin active >/dev/null 2>&1
pkill -RTMIN+1 waybar