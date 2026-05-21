#!/usr/bin/env bash
WORKSPACE=$(dirname "${BASH_SOURCE[0]:-0}")

source "$WORKSPACE"/_common/utils.sh
source $(get_env_file "${BASH_SOURCE[0]:-0}")
# create env file with:
# NOTES_WORK_PATH=
# NOTES_PERSONAL_PATH=

case "$1" in
    random)   FILE=$(get_temp_file_named "code-temp-$(date +%s)-$RANDOM");;
    work)     FILE=$NOTES_WORK_PATH;;
    personal) FILE=$NOTES_PERSONAL_PATH;;
    *) exit;;
esac

hyprctl eval "Open_floating_note('$FILE')"
