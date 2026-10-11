#!/usr/bin/env bash
set -euo pipefail

fail() {
    notify-send --app-name="Phone screen sharing" --urgency critical "Phone screen sharing" "$1" || true
    printf '%s\n' "$1" >&2
    exit 1
}

for dependency in adb scrcpy avahi-browse timeout; do
    command -v "$dependency" >/dev/null || fail "Missing dependency: $dependency"
done

adb start-server >/dev/null 2>&1 || fail "Unable to start ADB."

# Discover the current wireless debugging port rather than saving a stale one.
# IPv4 and IPv6 advertisements can resolve to the same IPv4 endpoint.
services=$(timeout 8s avahi-browse -rtp _adb-tls-connect._tcp 2>/dev/null || true)
mapfile -t endpoints < <(printf '%s\n' "$services" |
    awk -F ';' '$1 == "=" && $8 ~ /^[0-9.]+$/ && $9 ~ /^[0-9]+$/ { print $8 ":" $9 }' |
    sort -u)

if (( ${#endpoints[@]} > 1 )); then
    fail "Multiple phones advertise Wireless debugging. Enable it only on the phone you want to share."
elif (( ${#endpoints[@]} == 1 )); then
    endpoint=${endpoints[0]}
    timeout 10s adb connect "$endpoint" >/dev/null 2>&1 ||
        fail "Unable to connect to the phone. Check Wireless debugging and pairing."
else
    # An existing connection still works when multicast discovery is unavailable.
    mapfile -t endpoints < <(adb devices |
        awk '$2 == "device" && $1 ~ /:[0-9]+$/ { print $1 }')
    (( ${#endpoints[@]} == 1 )) ||
        fail "No unique wireless phone found. Enable Wireless debugging on the same local network and ensure this computer is paired."
    endpoint=${endpoints[0]}
fi

[[ $(timeout 5s adb -s "$endpoint" get-state 2>/dev/null || true) == device ]] ||
    fail "The phone is unavailable. Check Wireless debugging and pairing."

log_file=$(mktemp)
trap 'rm -f "$log_file"' EXIT
# Set only the height: scrcpy calculates the width from the phone's aspect ratio.
window_height=$(hyprctl monitors -j 2>/dev/null |
    jq -er '.[] | select(.focused) | (.height / .scale * 0.75 | floor)' 2>/dev/null || true)
window_height=${window_height:-900}
if ! scrcpy --serial="$endpoint" --window-title="Phone screen" --window-height="$window_height" 2> >(tee "$log_file" >&2); then
    fail "scrcpy failed: $(tail -n 3 "$log_file")"
fi
