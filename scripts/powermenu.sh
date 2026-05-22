#!/usr/bin/env bash

log_inactive() {
    "$ZDOTDIR/scripts/status/manager.sh" --log-system-event inactive
}

show_menu() {
    # icon  label
    local entries=(
        $''  Reboot
        $''  Lock
        $''  Logout
        $''  Shutdown
        $''  Bios
    )

    local rows=()
    local i
    for ((i = 0; i < ${#entries[@]}; i += 2)); do
        local icon=${entries[i]} label=${entries[i + 1]}
        rows+=("<span size=\"x-large\">${icon}</span>\n${label}")
    done

    local IFS='|'
    printf '%b' "${rows[*]}" \
        | rofi -sep '|' -markup-rows -eh 4 -dmenu -case-smart -sort -sorting-method fzf \
               -theme ~/.config/rofi/themes/custom-row.rasi -p ""
}

chosen="$1"
if [[ -z "$chosen" ]]; then
    chosen=$(show_menu)
fi

case $chosen in
    *Reboot*)   log_inactive; systemctl reboot;;
    *Lock*)     log_inactive; loginctl lock-session;;
    *Logout*)   log_inactive; hyprctl dispatch exit;;
    *Shutdown*) log_inactive; systemctl poweroff;;
    *Bios*)     log_inactive; systemctl reboot --firmware-setup;;
    *)          exit 0;;
esac
