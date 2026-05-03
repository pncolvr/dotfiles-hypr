#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/shared/common.sh"

REPO_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
FILE="$REPO_DIR/config/submaps.lua"

SUBMAP="${1}"

load_lua_vars "$FILE"

awk -v name="$SUBMAP" '
    /hl\.define_submap\("/ && index($0, "\"" name "\"") { capture = 1 }
    capture && /^end\)/ { capture = 0 }
    capture && /hl\.bind/ {
        if ($0 ~ /hl\.dsp\.submap\(/) next
        print
    }
' "$FILE" | awk_parse_bind