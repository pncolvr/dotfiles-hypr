#!/usr/bin/env bash

# optional: filter by submap name (empty = global)
SUBMAP="${1:-}"

decode_modmask() {
    local mask=$1
    local parts=()
    (( mask & 64 )) && parts+=("SUPER")
    (( mask & 8  )) && parts+=("ALT")
    (( mask & 4  )) && parts+=("CTRL")
    (( mask & 1  )) && parts+=("SHIFT")
    local result
    printf -v result '%s + ' "${parts[@]}"
    echo "${result% + }"
}

while IFS=$'\t' read -r modmask key desc; do
    mods=$(decode_modmask "$modmask")
    combo="${mods:+$mods + }$key"
    printf '%s;%s\n' "$combo" "$desc"
done < <(
    hyprctl binds -j | jq -r \
        --arg submap "$SUBMAP" \
        '.[] | select(.has_description and .submap == $submap and .catch_all == false) | [.modmask, .key, .description] | @tsv'
)
