#!/usr/bin/env bash

pkill -SIGUSR2 waybar

pkill hyprpaper
hyprpaper & disown

killall shellevents -USR1

pkill pypr
pypr & disown
