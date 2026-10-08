#!/usr/bin/env bash
set -euo pipefail

has_window() {
    hyprctl clients -j | jq -e --arg class "$1" \
        'any(.[]; .class == $class and .mapped != false)' >/dev/null
}

for app in discord teams-for-linux; do
    if ! has_window "$app"; then
        hyprctl repl "hl.dispatch(hl.dsp.exec_cmd(\"${app}\"))" >/dev/null
    fi

    deadline=$((SECONDS + 30))
    until has_window "$app"; do
        if (( SECONDS >= deadline )); then
            notify-send --urgency critical "Unable to find application window" "$app"
            exit 1
        fi
        sleep 0.3
    done
done

hyprctl repl '
    local discord = assert(hl.get_window("class:^(discord)$"))
    local teams = assert(hl.get_window("class:^(teams-for-linux)$"))

    if not discord.group or discord.group ~= teams.group then
        if teams.group then
            teams.group:remove(teams)
        end
        hl.dispatch(hl.dsp.window.float({ window = discord, action = "disable" }))
        hl.dispatch(hl.dsp.window.float({ window = teams, action = "disable" }))
        if not discord.group then
            hl.dispatch(hl.dsp.group.toggle({ window = discord }))
        end
        discord.group:add(teams)
    end

    assert(discord.group and discord.group == teams.group, "Unable to group apps")
    hl.dispatch(hl.dsp.focus({ window = teams }))
' >/dev/null

printf '%s' 'hello, bom dia' | wl-copy
