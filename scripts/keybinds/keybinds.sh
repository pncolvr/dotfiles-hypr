#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/shared/common.sh"

REPO_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
FILE="$REPO_DIR/config/keybinds.lua"

load_lua_vars "$FILE"

grep -E '^[[:space:]]*hl\.bind' "$FILE" | awk_parse_bind