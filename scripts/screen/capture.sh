#!/usr/bin/env bash
workspace=$(echo "$0" | xargs realpath | xargs dirname)
source "$workspace"/common/utils.sh

videos_folder=~/Videos/Recordings
TEMP_DIR="${XDG_RUNTIME_DIR:-${TMPDIR:-/tmp}}"

function handleCaptureOutput() {
    outputs=$(hyprctl monitors -j | jq --raw-output '.[] | .name')
    output=$(printf '%s\n' "${outputs[@]}" | sort | rofi -dmenu -i -p "")
    if [[ -n "$output" ]]; then
        capture "$output" "$(selectRegion)"
    fi
}

function handleCaptureRegion() {
    capture "" "$(slurp -d)"
}

headphones="alsa_output.usb-Logitech_PRO_X_2_LIGHTSPEED_0000000000000000-00.analog-stereo.monitor"
mic="alsa_input.usb-Logitech_PRO_X_2_LIGHTSPEED_0000000000000000-00.mono-fallback"
function handleAudioChoice() {
    include=$(echo "none|both|desktop|mic" | rofi -sep '|' -dmenu -i -p "")
    case "$include" in
        none) echo -n "";;
        desktop) echo -n "$headphones";;
        mic) echo -n "$mic";;
        both) 
            loadLoopback
            echo -n "$headphones";;
        *) exit 1;;
    esac
}

loopback_id_file="$TEMP_DIR/loopback.id"

loadLoopback() {
    : > "$loopback_id_file"
    local id

    id=$(pactl load-module module-loopback) && echo "$id" >> "$loopback_id_file"

    # Give PipeWire time to register nodes
    sleep 0.25
}

unloadLoopback() {
    [[ -f "$loopback_id_file" ]] || return
    while read -r mid; do
        [[ -n "$mid" ]] && pactl unload-module "$mid" >/dev/null 2>&1 || true
    done < "$loopback_id_file"
    rm -f "$loopback_id_file"
}

function requestFps () {
    fps=$(echo "60|30|15" | rofi -sep '|' -dmenu -i -p "")
    case "$fps" in 
        60|30|15) echo "$fps";;
        *) exit 1;;
    esac
}

function capture () {
    local output=$1
    local region=$2
    local audio
    local filename
    local file
    local params=" "
    fps=$(requestFps)
    [ -z "$fps" ] && exit 0
    audio=$(handleAudioChoice)
    [ -n "$output" ] && params+=" --output $output"
    [ -n "$region" ] && params+=" --geometry \"$region\""
    file=$(date '+%Y-%m-%d_%H:%M:%S').mp4
    filename="$videos_folder/$file"

    hyprctl notify -1 1000 "rgb(2E7D32)" "recording starting" > /dev/null 2>&1
    sleep 1.1
    command="wf-recorder $params \
        --codec hevc_nvenc \
        --codec-param preset=llhq \
        --codec-param rc=vbr_hq \
        --codec-param cq=21 \
        --codec-param rc-lookahead=32 \
        --codec-param bf=3 \
        --codec-param spatial_aq=1 \
        --codec-param temporal_aq=1 \
        --codec-param aq-strength=10 \
        --framerate $fps"
 
    [ -n "$audio" ] && command+=" --audio=$audio"
    
    command+=" -f \"$filename\""

    echo "$command"
    cast_status=$(cat "$TEMP_DIR/screencast_status")
    echo "1" > "$TEMP_DIR/screencast_status"
    eval "$command"
    status=$?
    echo "$status"
    if [[ $status -ne 0 ]]; then
        hyprctl notify -1 3000 "rgb(FF0000)" "recording error" > /dev/null 2>&1
    fi

    unloadLoopback
    echo "$cast_status" > "$TEMP_DIR/screencast_status"
    # systemctl --user restart pipewire pipewire-pulse
    hyprctl notify -1 1000 "rgb(2E7D32)" "recording stopped" > /dev/null 2>&1
    openFileExplorer "$filename"
}

function handleCapture() {
    chosen=$(echo "output|region" | rofi -sep '|' -dmenu -i -p "")
    case $chosen in
        *output*) handleCaptureOutput;;
        *region*) handleCaptureRegion;;
        *)exit 0;;
    esac
}

function handleStop() {
    pkill -SIGINT wf-recorder
}

if ! pgrep -xi "wf-recorder" > /dev/null
then
    handleCapture
else
    handleStop
fi
