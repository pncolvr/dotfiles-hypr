#!/usr/bin/env bash

FILE="$HOME/.config/hypr/config.d/keybinds.conf"

grep -E '^[[:space:]]*bind' "$FILE" \
| sed -E '
    s/^[[:space:]]*bind([e|r|l|c|g|o|n|m|t|i|s|d|p|u|k]?)*[[:space:]]*=[[:space:]]*//
    s/\$mainMod/SUPER/g

    s/[[:space:]]+/ /g
    s/^ //g
    s/ $//g

    s/^([^,]*),([^,]*),([^,]*),(.*)$/\1 + \2;\3 \4/
    s/^([^,]*),([^,]*),([^,]*)$/\1 + \2; \3/
    s/^([^,]*),([^,]*)$/\1;\2/

    s/^([^+]*) ([^+;]*); /\1 + \2; /

    s/[[:space:]]+/ /g

    s/^ \+ //g

    s/^[[:space:]]+//; s/[[:space:]]+$//
'
