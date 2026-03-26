#!/usr/bin/env bash

function openFileExplorer () {
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