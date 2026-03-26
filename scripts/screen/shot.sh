#!/usr/bin/env bash

workspace=$(echo "$0" | xargs realpath | xargs dirname)
source "$workspace"/common/utils.sh

pictures_folder=~/Pictures/Screenshots

function pick() {
  rofi -dmenu -case-smart -sort -sorting-method fzf -p ""
}

function capture_screenshot() {
    local method=${1:-region}
    timeout 30 hyprshot --freeze --silent --clipboard-only --raw --mode "$method"
}

function screenshot() {
    local method=$1
    local filename
    local file
    file=$(date '+%Y-%m-%d_%H:%M:%S').png
    filename="$pictures_folder/$file"
    capture_screenshot "$method" | satty --filename - --output-filename "$filename"

    if [[ -f "$filename" ]]; then
        openFileExplorer "$filename"
    fi
}

function detect_qrcode() {
    local qr_result
    qr_result=$(capture_screenshot region | zbarimg --raw -q - 2>/dev/null)

    if [[ -n "$qr_result" ]]; then
        notify-send "$qr_result"
        echo "$qr_result" | wl-copy
    else
        notify-send "No QR code found in selected region"
    fi
}

function detect_text() {
    echo "Capturing region for OCR text detection..."
    local ocr_result

    ocr_result=$(capture_screenshot region | tesseract stdin stdout -l por 2>/dev/null)
    if [[ -n "$ocr_result" ]]; then
        notify-send "$ocr_result"
        echo "$ocr_result" | wl-copy
        echo "$ocr_result"
    else
        notify-send "No readable text found in selected region"
    fi
}

method=$1

if [[ -z "$method" ]]; then
    selected=$(echo -e "ocr\noutput\nqrcode\nregion\nwindow" | pick)
    if [[ -n "$selected" ]]; then
        method="$selected"
    fi
fi

case "$method" in
    region|output|window) screenshot "$method";;
    qrcode) detect_qrcode;;
    ocr) detect_text;;
    *) echo "Usage: $0 {region|output|window|qrcode|ocr}" && exit 1;;
esac