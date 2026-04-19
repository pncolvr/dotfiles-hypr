#!/usr/bin/env bash

function hypr_shutdown() {
    local message="$1"
    local cmd="$2"
    log_inactive
    hyprshutdown --top-label "$message" --post-cmd "$cmd"
}

function lock () {
    log_inactive
    loginctl lock-session
}

function logout() {
    log_inactive
    hyprshutdown --top-label "Logging out..."
}

function log_inactive() {
    $ZDOTDIR/scripts/status/manager.sh --log-system-event inactive
}

chosen="$1"
if [[ -z "$chosen" ]]; then
    chosen=$(echo -n " Reboot| Lock| Logout| Shutdown| Bios| Cancel" | rofi -sep '|' -dmenu -case-smart -sort -sorting-method fzf -p "")
fi

case $chosen in
    *Reboot*) hypr_shutdown 'Restarting...' 'systemctl reboot';;
    *Lock*) lock;;
    *Logout*) logout;;
    *Shutdown*) hypr_shutdown 'Shutting down...' 'systemctl poweroff';;
    *Bios*) hypr_shutdown 'Restarting to bios...' 'systemctl reboot --firmware-setup';;
    *) echo "none" && exit 0;;
esac

