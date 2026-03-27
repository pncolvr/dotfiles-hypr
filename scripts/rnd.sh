#!/usr/bin/env bash
SLIDESHOW_DIRECTORY="$1"

function random () {
    close
    img=$(find "$SLIDESHOW_DIRECTORY" -maxdepth 2 -type f | shuf -n 1)
    echo "$img" | imv -w rnd > /dev/null 2>&1 & disown
}

function close () {
    pkill imv
}

random