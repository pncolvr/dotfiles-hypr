#!/usr/bin/env bash
SCRIPT_DIR=$(dirname "${BASH_SOURCE[0]:-0}")
WORKSPACE=$(cd -- "$SCRIPT_DIR/../.." && pwd)

source "$WORKSPACE"/_common/utils.sh

id=$("$SCRIPT_DIR"/create.cs)
copy_to_clipboard_and_notify "$id"
