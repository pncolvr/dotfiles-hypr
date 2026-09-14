#!/usr/bin/env bash

DEFAULT_BROWSER="$ZDOTDIR/scripts/default-browser/default-browser.sh"

entry=$(wl-paste --no-newline)

"$DEFAULT_BROWSER" "$entry"
