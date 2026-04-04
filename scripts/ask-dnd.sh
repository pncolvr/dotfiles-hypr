#!/usr/bin/env bash
# todo: have some logic to replace notification on status change, check https://man.archlinux.org/man/notify-send.1.en
function reload-waybar() {
    pkill -RTMIN+2 waybar > /dev/null 2>&1
}
function get-dnd() {
   swaync-client --get-dnd 2>/dev/null
}

function enable-dnd() {
   swaync-client --dnd-on > /dev/null 2>&1
   reload-waybar
}

function disable-dnd() {
   swaync-client --dnd-off > /dev/null 2>&1
   reload-waybar
} 

function is-any-window-fullscreen() {
    hyprctl clients -j 2>/dev/null | jq -e 'any(.[]?; .fullscreen == 2 or .fullscreen == 3)' >/dev/null
}

function ask-and-set-dnd() {
    local current_dnd
    local title
    local body
    local selected_action

    current_dnd="$(get-dnd)"

    if [[ "$current_dnd" == "true" ]]; then
        return
    fi

    body="Do you want to enable DND?"
    title="Entered fullscreen"
    #todo: think how to handle this for games as they can block mouse movement
    selected_action="$(notify-send --urgency=normal --transient "$title" "$body" --action="yes=Yes" --action="no=No" --expire-time=5000)"
    case "$selected_action" in
        yes)
            enable-dnd
            ;;
        no)
            ;;
    esac
}

function handle-left-fullscreen() {
    local current_dnd

    current_dnd="$(get-dnd)"
    if [[ "$current_dnd" != "true" ]]; then
        return
    fi

    if is-any-window-fullscreen; then
        return
    fi

    disable-dnd
    notify-send --urgency=normal --transient "Left fullscreen" "Notifications enabled"
}

function handle-entered-fullscreen() {
    if ! is-any-window-fullscreen; then
        return
    fi

    ask-and-set-dnd
}

case "$1" in
    fullscreen-left) handle-left-fullscreen;;
    fullscreen-entered) handle-entered-fullscreen;;
esac

