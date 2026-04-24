#!/usr/bin/env bash
SUBMAP="$1"
CONF="$HOME/.config/hypr/config.d/submaps.conf"

awk "/submap = $1/,/submap = reset/" "$CONF" \
    | grep -E '^[[:space:]]*bind' \
    | grep -vE 'bind.*= *, *,|bind.*(escape|catchall).*, *submap, *reset' \
    | sed -E 's/^[[:space:]]*bind([e|r|l|c|g|o|n|m|t|i|s|d|p|u|k]?)*[[:space:]]*=[[:space:]]*,[[:space:]]*//' \
    | sed -E 's/exec,//' \
    | sed -E 's/,/;/'