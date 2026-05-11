#!/usr/bin/env bash

hyprctl dispatch 'hl.dsp.window.pin()'
pkill -RTMIN+1 waybar