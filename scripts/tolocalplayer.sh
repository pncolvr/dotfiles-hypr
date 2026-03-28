#!/usr/bin/env bash

source "$HOME"/.config/rofi/scripts/_common/utils.sh

TWITCH_FILE="$(get_temp_file_named twitch_online)"
OPTIONS_FILE="$(get_temp_file_named local_player_options)"

function get_possible_options () {
    if [[ -n $2 && -n $3 ]]; then
        echo "\"$2\"=\"$("$HOME"/Projects/scripts/utils/browser/url-clean.sh "$3")\"" > "$1"
    else 
        cp "$TWITCH_FILE" "$1"
        # disabling for now add:🎬 later
        # printf '"%s"="%s"\n' "🟣 $user" "https://www.twitch.tv/$user" >> "$ONLINE_FILE"
        # 
        # browser_active_session=~/.local/share/qutebrowser/sessions/_autosave.yml
        # if [[ -f "$browser_active_session" ]]; then
        #     yq '
        #     .windows[].tabs[].history[]
        #         | select(.active == true)
        #         | select(
        #         (
        #             (.url | test("^https?://(www\\.)?youtube\\.com/.*watch")) and
        #             (.url | test("[?&]v=[^&]+"))
        #         ) or
        #         (.url | test("^https?://(www\\.)?twitch\\.tv/[^/?#]+$"))
        #         )
        #         | "\(.title)=\(.url)"' "$browser_active_session" \
        #     | sed -E 's/=/"="/' \
        #     | perl -MHTML::Entities -pe 'decode_entities($_);' >> "$1"
        # fi
    fi
}

function show_error() {
    hyprctl notify -1 3000 "rgb(FE8D59)" "$1" > >(log) 2> >(log_error)
}

function pause_player() {
    v=$(playerctl --list-all | grep "$1")
    if [ -n "$v" ]; then
        playerctl --player "$v" pause > >(log) 2> >(log_error)
    fi
}

function move_to_media_workspace() {
    hyprctl dispatch workspace 2 > >(log) 2> >(log_error)
}

function get_source() {
    if [[ "$1" == *"twitch"* ]]; then
        echo -n "twitch"
    elif [[ "$1" == *"youtube"* ]]; then
        echo -n "youtube"
    fi
}

function get_mpv_class_name() {
    case $1 in 
        twitch|youtube) echo -n "mpv-$1";;
        *) log_error "unknown player $1" && exit 1;;
    esac
}

function handle_open_source() {
    case $2 in 
        twitch) handle_open_twitch "$1";;
    esac
}

function handle_close_source() {
    case $1 in 
        twitch) handle_close_twitch;;
    esac
}

function handle_open_twitch() {
    chat="https://www.twitch.tv/popout/$(get_channel "$1")/chat?popout="
    qutebrowser --desktop-file-name qutebrowser-twitch-chat \
        --target window \
        -C ~/.config/qutebrowser/config.py \
        -B ~/.local/share/qutebrowser-twitch-chat \
        "$chat" > >(log) 2> >(log_error) & disown
}

function handle_close_twitch() {
    hyprctl dispatch closewindow class:qutebrowser-twitch-chat > >(log) 2> >(log_error) 2>&1
    hyprctl dispatch closewindow class:mpv-twitch > >(log) 2> >(log_error) 2>&1
}

function get_channel() {
    local channel
    channel=$(echo "$1" | sed -E 's~https?://(www\.)?twitch.tv/([^/?#]+)/?.*~\2~')
    if [[ -z "$channel" ]]; then
        show_error "Failed to parse Twitch channel"
        exit 1
    fi
    echo -n "$channel"
}

function wait_for_window() {
    local class="$1"
    local timeout=5
    local start
    start=$(date +%s)
    while true; do
        if hyprctl clients -j | jq -r '.[].class' | grep -Fx "$class" > >(log) 2> >(log_error); then
            return 0
        fi
        if (( $(date +%s) - start >= timeout )); then
            log "timeout waiting for $class"
            return 1
        fi
        sleep 0.05
    done
}

function play() {
    # https://www.reddit.com/r/youtubedl/comments/ou1mtk/ytdlp_how_i_use_cookies_from_browser/
    # create vivaldi profile and use --cookies-from-browser BROWSER[:PROFILE_NAME_OR_PATH]
    # --cookies-from-browser BROWSER[:PROFILE_NAME_OR_PATH]
    local url
    url=$1
    local source
    source=$2

    class=$(get_mpv_class_name "$source")
    force_close_previous_of_same_type $class
    mpv --force-window=immediate --wayland-app-id="$class" \
        "$url" > >(log) 2> >(log_error) &
    
    local mpv_pid=$!
    wait_for_window "$class"
    handle_open_source "$url" "$source"
    wait "$mpv_pid"
    status=$?
    if [[ $status -ne 0 ]]; then
        show_error "Playback failed"
    fi

    handle_close_source "$source"
}

function force_close_previous_of_same_type() {
    local class=$1
    case $class in 
        mpv-twitch) 
            handle_close_twitch;;
        mpv-youtube)
            hyprctl dispatch closewindow class:mpv-youtube > >(log) 2> >(log_error);;
    esac 
}


get_possible_options $OPTIONS_FILE "$1" "$2"
count=$(cat "$OPTIONS_FILE" | wc -l)

if [[ -s "$OPTIONS_FILE" && "$count" -gt 0 ]]; then 
    chosen=$("$HOME"/.config/rofi/scripts/_common/handle.sh "$OPTIONS_FILE" "open" output)
    code=$!
    if [[ -n $chosen && "$code" -ne 1 ]]; then 
        pause_player chromium.instance
        source=$(get_source "$chosen")
        play "$chosen" "$source"
    fi
else
    show_error "No links found"
fi
