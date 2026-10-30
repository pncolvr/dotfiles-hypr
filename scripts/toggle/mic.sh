#!/usr/bin/env bash
set -euo pipefail

# Ignore overlapping key events while the two audio controls settle.
exec 9>"${XDG_RUNTIME_DIR:-/tmp}/hypr-mic-mute-${UID}.lock"
flock -n 9 || exit 0

source_name=$(pactl get-default-source)
case "$(LC_ALL=C pactl get-source-mute "$source_name")" in
    "Mute: yes") target=0 ;;
    "Mute: no") target=1 ;;
    *) exit 1 ;;
esac

# Read Discord's actual checkbox instead of assuming it matches the microphone.
script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
if ! bash "$script_dir/../tools/discord-voice.sh" mute "$target"; then
    notify-send "Discord audio sync failed" "The system microphone control will still be applied." || true
fi
sleep 0.2
pactl set-source-mute "$source_name" "$target"
