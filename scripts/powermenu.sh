#!/usr/bin/env bash

function bios() {
    log_inactive
    systemctl reboot --firmware-setup
}

function reboot() {
    log_inactive
    systemctl reboot
}

function shutdown() {
    log_inactive
    systemctl poweroff
}

function lock() {
    log_inactive
    loginctl lock-session
}

function logout() {
    log_inactive
    hyprctl dispatch exit
}

function log_inactive() {
    $ZDOTDIR/scripts/status/manager.sh --log-system-event inactive
}

chosen="$1"
if [[ -z "$chosen" ]]; then
    chosen=$(echo -n " Reboot| Lock| Logout| Shutdown| Bios| Cancel" | rofi -sep '|' -dmenu -case-smart -sort -sorting-method fzf -p "")
fi

case $chosen in
    *Reboot*) reboot;;
    *Lock*) lock;;
    *Logout*) logout;;
    *Shutdown*) shutdown;;
    *Bios*) bios;;
    *) echo "none" && exit 0;;
esac
