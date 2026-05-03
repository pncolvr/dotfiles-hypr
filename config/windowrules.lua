-- --------------------------------------------------------------------------
-- workspace rules 
-- --------------------------------------------------------------------------

hl.workspace_rule({ workspace = "2", layout = "master" })

-- --------------------------------------------------------------------------
-- variables 
-- --------------------------------------------------------------------------
local terminalClass = "com.mitchellh.ghostty"
local editorClass = "code"
local dialogClass = "yad"
local steamClass = "steam"

local moveWindowToCursor = "(cursor_x-(window_w*0.5)) (max(25, cursor_y-(window_h*0.5)))"

-- --------------------------------------------------------------------------
-- window rules 
-- --------------------------------------------------------------------------

local groupWorkspaces = {3, 4, 10}
for _, ws in ipairs(groupWorkspaces) do
  hl.window_rule({
    name  = "dont_group",
    match = { workspace = tostring(ws) },
    group = "barred",
  })
end

hl.window_rule({
    name = "browser_workspace",
    match = { class = "org.qutebrowser.qutebrowser" },
    workspace = "1"
})

hl.window_rule({
    name = "mpv_float",
    match = { class = "^(mpv.*)$" },
    float = true,
    center = true
})

hl.window_rule({
    name = "mpv_rollback_tile_twitch",
    match = { class = "mpv-twitch" },
    float = false,
    workspace = "2"
})

hl.window_rule({
    name = "comms_workspace",
    match = { class = "^(discord|teams-for-linux|signal)$" },
    group = "set comms",
    workspace = "3",
    no_screen_share = true
})

hl.window_rule({
    name = "code_workspace",
    match = { class = editorClass, float = false },
    group = "set code",
    workspace = "4"
})

hl.window_rule({
    name = "code_dialogs_move_to_mouse",
    match = { class = editorClass, float = true },
    move = moveWindowToCursor
})

hl.window_rule({
    name = "yad_move_to_mouse",
    match = { class = dialogClass, title = "qrencode" },
    float = true,
    move = moveWindowToCursor
})

hl.window_rule({
    name = "yad_submap",
    match = { class = dialogClass, title = "^(Submap:.*)$" },
    float = true,
    pin = true,
    no_initial_focus = true,
    move = "(monitor_w-window_w-10) (35)"
})

hl.window_rule({
    name = "fzf_keybinds",
    match = { class = terminalClass, title = "Keybinds" },
    float = true,
    size = "(monitor_w*0.4) (monitor_h*0.8)"
})

hl.window_rule({
    name = "game_workspace",
    match = { class = "^(".. steamClass .. "|heroic|org\\.prismlauncher\\.PrismLauncher)$" },
    workspace = "5"
})

hl.window_rule({
    name = "tools_workspace",
    match = { class = "^(Bazecor|bruno|com\\.shellyorg\\.shelly)$" },
    workspace = "6"
})

hl.window_rule({
    name = "reading_workspace",
    match = { class = "^(org\\.pwmt\\.zathura)$" },
    workspace = "7"
})

hl.window_rule({
    name = "rdp_workspace",
    match = { class = "com.freerdp.client.sdl3" },
    group = "set rdp",
    workspace = "10"
})

hl.window_rule({
    name = "center_modals",
    match = { modal = true },
    float = true,
    center = true,
    size = "900 700"
})

hl.window_rule({
    name = "center_steam_login",
    match = { class = steamClass, title = "^(Sign in to Steam)$", float = true },
    center = true
})

hl.window_rule({
    name = "center_windows_no_title",
    match = { class = "^(xdg-desktop-portal-gtk|org\\.pulseaudio\\.pavucontrol|hyprland-share-picker|imv|io\\.github\\.Qalculate\\.qalculate-qt|com\\.gabm\\.satty|engrampa)$" },
    float = true,
    center = true,
    size = "900 700"
})

hl.window_rule({
    name = "center_copyq",
    match = { class = "com.github.hluk.copyq" },
    float = true,
    center = true,
    pin = true,
    size = "900 700"
})

hl.window_rule({
    name = "position_uxplay",
    match = { class = "uxplay" },
    float = true,
    move = "(monitor_w*0.78) (monitor_h*0.12)"
})

hl.window_rule({
    name = "position_dropdown_term",
    match = { class = terminalClass, title = "dropdown-term" },
    float = true,
    pin = true,
    move = "(monitor_w*0.025) (monitor_h*0.03)",
    size = "(monitor_w*0.95) (monitor_h*0.47)"
})

hl.window_rule({
    name = "position_musicplayer",
    match = { class = terminalClass, title = "musicplayer" },
    float = true
})

hl.window_rule({
    name = "position_wallpapers",
    match = { class = terminalClass, title = "wallpapers" },
    float = true,
    center = true,
    size = "(monitor_w*0.6) (monitor_h*0.5)"
})

hl.window_rule({
    name = "position_passwords",
    match = { class = terminalClass, title = "passwords" },
    float = true,
    center = true,
    pin = true,
    no_screen_share = true,
    size = "(monitor_w*0.6) (monitor_h*0.8)"
})

hl.window_rule({
    name = "center_webapps",
    match = { class = "^(qutebrowser-webapp|.*-.*\\.(com|org|tv).*|vivaldi-localhost__.*)$" },
    float = true,
    center = true,
    size = "1500 900"
})

hl.window_rule({
    name = "webapps_rollback_tile_twitch",
    match = { class = "^(qutebrowser-twitch.*)$" },
    float = false
})

hl.window_rule({
    name = "position_imv_rnd",
    match = { class = "imv", title = "rnd" },
    pin = true,
    size = "340 600",
    move = "2200 810"
})

hl.window_rule({
    name = "drag_drop",
    match = { class = "it.catboy.ripdrag" },
    pin = true
})

hl.window_rule({
    name = "recolor_pin",
    match = { pin = true },
    border_color = "rgb(170,190,220)"
})

-- --------------------------------------------------------------------------
-- layer rules 
-- --------------------------------------------------------------------------

-- local notificationsLayer = hl.layer_rule({
hl.layer_rule({
    name  = "hide_notifications",
    match = { namespace = "swaync-notification-window" },
    no_screen_share = true,
})
-- notificationsLayer:set_enabled(true)

-- --------------------------------------------------------------------------
-- smart gaps (black magic)
-- --------------------------------------------------------------------------
hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
hl.window_rule({
    name  = "no-gaps-wtv1",
    match = { float = false, workspace = "w[tv1]" },
    border_size = 0,
    rounding    = 0,
})
hl.window_rule({
    name  = "no-gaps-f1",
    match = { float = false, workspace = "f[1]" },
    border_size = 0,
    rounding    = 0,
})