#!/usr/bin/env bash

# pkill -SIGUSR2 waybar
killall quickshell
quickshell & disown
killall shellevents -USR1

killall conky
"$HOME"/.config/conky/start.sh & disown