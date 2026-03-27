#!/usr/bin/env bash

function open_file_explorer () {
    local file=$1
    if [[ -f "$file" ]]; then
        dbus-send --type=method_call --dest=org.freedesktop.FileManager1 /org/freedesktop/FileManager1 org.freedesktop.FileManager1.ShowItems array:string:"file://$file" string:""
    elif [[ -d $file ]]; then
        xdg-open "$file"
    else 
        pcmanfm-qt "$file"
    fi
    hyprctl dispatch focuswindow class:pcmanfm-qt
}

function get_temp_dir() {
    echo "${XDG_RUNTIME_DIR:-/tmp}"
}

function get_temp_file_named() {
  local name=$1
  echo "$(get_temp_dir)/${name}_$(id -u)"
}

function get_env_file() {
    local path=$1
    local filename=$(basename "$path")
    filename="${filename%.*}"
    echo "$(dirname "$path")/$filename.env"
}

function calculate_cursor_move_to_position() {
    local active_workspace
    active_workspace=$1
    local x_percent
    x_percent=$2 
    local y_percent
    y_percent=$3
    local active_monitor
    local screen_resolution
    local screen_width
    local screen_height
    local cursor_x
    local cursor_y
    

    active_monitor=$(echo "$active_workspace" | jq -r '.monitor')
    screen_resolution=$(hyprctl monitors -j | jq -r --arg monitor "$active_monitor" '.[] | select(.name == $monitor) | .width, .height')
    screen_width=$(echo "$screen_resolution" | head -n1)
    screen_height=$(echo "$screen_resolution" | tail -n1)
    cursor_x=$(echo "$screen_width * $x_percent / 1" | bc | cut -d. -f1)
    cursor_y=$(echo "$screen_height * $y_percent / 1" | bc | cut -d. -f1)

    echo -n "$cursor_x $cursor_y"
}

function wait_for_window() {
    local class
    class=$1
    local title
    title=$2
    local window_address
    window_address=""
    while [[ -z "$window_address" && $SECONDS -lt 60 ]]; do
        sleep 0.3
        window_address=$(hyprctl clients -j | jq -r --arg class "$class" --arg title "$title" \
            '.[] | select(.class == $class) | select(.title | test($title)) | .address')
    done
    if [[ -n "$window_adress" ]]; then
        notify-send --urgency critical "unable to find window" "$title @ $class"
    fi
    echo "$window_address"
}