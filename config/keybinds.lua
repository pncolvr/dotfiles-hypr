local home = os.getenv("HOME")
local scripts = home .. "/.config/hypr/scripts"
local rofi    = home .. "/.config/rofi/scripts"

local mainMod = "SUPER"
-- general
hl.bind(mainMod .. " + SHIFT + PERIOD",  hl.dsp.exec_cmd(scripts .. "/directory/books-pick.sh --pick"), { desc = "pick a book to read" })
hl.bind(mainMod .. " + SHIFT + SLASH",   hl.dsp.exec_cmd("ghostty --title=Keybinds -e " .. scripts .. "/keybinds/display.sh --keybinds"), { desc = "show keybinds" })
hl.bind(mainMod .. " + SHIFT + A",       hl.dsp.exec_cmd(rofi ..    "/web/azure.sh --pick"),                                              { desc = "open azure" })

hl.bind(mainMod .. " + B",         hl.dsp.exec_cmd(scripts .. "/browser/openbookmarks.sh"),          { desc = "open bookmarks" })
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd("xdg-open https://www.monday.com"),               { desc = "open monday.com" })

hl.bind(mainMod .. " + D",         hl.dsp.exec_cmd("rofi -show drun"),                               { desc = "app launcher" })
hl.bind(mainMod .. " + SHIFT + D", hl.dsp.exec_cmd(rofi .. "/remotes/pick.sh"),                      { desc = "pick remote" })

hl.bind(mainMod .. " + E",         hl.dsp.exec_cmd(rofi .. "/web/webapps.sh"),                       { desc = "open web app" })

hl.bind(mainMod .. " + ESCAPE",       hl.dsp.exec_cmd(scripts .. "/powermenu.sh"),                   { desc = "power menu" })
hl.bind(mainMod .. " + SHIFT + ESCAPE", hl.dsp.exec_cmd("qs ipc call notifications toggle"),         { desc = "toggle notifications" })

hl.bind(mainMod .. " + F",         hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle"}), { desc = "toggle fullscreen" })
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle"}),  { desc = "toggle maximized" })

hl.bind(mainMod .. " + G",         hl.dsp.exec_cmd(rofi .. "/web/github.sh"),                        { desc = "open project on github" })

hl.bind(mainMod .. " + I",         hl.dsp.exec_cmd(scripts .. "/tolocalplayer.sh"),                  { desc = "open twitch or youtube on mpv" })
hl.bind(mainMod .. " + SHIFT + I", hl.dsp.exec_cmd(scripts .. "$scripts/rnd.sh " .. home .. "/Pictures/streamers/"), { desc = "random image" })

hl.bind(mainMod .. " + M",         hl.dsp.exec_cmd(scripts .. "/toggle/noscreenshare.sh"),           { desc = "toggle screenshare" })

hl.bind(mainMod .. " + SHIFT + N", hl.dsp.exec_cmd(rofi .. "/web/n8n.sh"),                          { desc = "open flow on n8n" })

hl.bind(mainMod .. " + P",         hl.dsp.exec_cmd(rofi .. "/code.sh"),                              { desc = "open project code" })

hl.bind(mainMod .. " + PRINT",         hl.dsp.exec_cmd(scripts .. "/screen/shot.sh"),                { desc = "screenshot" })
hl.bind(mainMod .. " + SHIFT + S",     hl.dsp.exec_cmd(scripts .. "/screen/shot.sh region"),         { desc = "screenshot region" })
hl.bind(mainMod .. " + SHIFT + PRINT", hl.dsp.exec_cmd(scripts .. "/screen/shot.sh window"),         { desc = "screenshot window" })
hl.bind("PRINT",                        hl.dsp.exec_cmd(scripts .. "/screen/shot.sh output"),         { desc = "screenshot output" })

hl.bind(mainMod .. " + Q",         hl.dsp.exec_cmd("hyprctl kill"),                                  { desc = "kill (pick)" })
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.close(),                                            { desc = "close window" })

hl.bind(mainMod .. " + R",         hl.dsp.exec_cmd(scripts .. "/screen/capture.sh"),                 { desc = "screen record" })
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd(scripts .. "/reload.sh"),                         { desc = "reload config" })

hl.bind(mainMod .. " + RETURN",         hl.dsp.exec_cmd(scripts .. "/toggle/terminal.sh"),           { desc = "toggle floating terminal" })
hl.bind(mainMod .. " + SHIFT + RETURN", hl.dsp.exec_cmd("ghostty"),                                  { desc = "new tiled terminal" })

hl.bind(mainMod .. " + T",         hl.dsp.exec_cmd(scripts .. "/directory/pick.sh"),                 { desc = "pick directory" })

hl.bind("ALT + TAB",         hl.dsp.exec_cmd(rofi .. "/windows/any.sh"),                             { desc = "switch window" })
hl.bind("ALT + SHIFT + TAB", hl.dsp.exec_cmd(rofi .. "/windows/currentworkspace.sh"),                { desc = "switch window (workspace)" })

hl.bind(mainMod .. " + TAB",         hl.dsp.exec_cmd("qs ipc call windows next"),                    { desc = "next window" })
hl.bind(mainMod .. " + SHIFT + TAB", hl.dsp.exec_cmd("qs ipc call windows prev"),                    { desc = "prev window" })

hl.bind(mainMod .. " + U",         hl.dsp.focus({ urgent_or_last = true }),                          { desc = "focus urgent/last" })

hl.bind(mainMod .. " + V",         hl.dsp.exec_cmd("copyq show"),                                    { desc = "clipboard manager" })

hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("ghostty --title=passwords -e ".. home .."/Projects/helpers/totp/handler.sh"), { desc = "vault" })

hl.bind(mainMod .. " + X",         hl.dsp.exec_cmd(scripts .. "/toggle/animations.sh"),              { desc = "toggle animations" })

hl.bind(mainMod .. " + Y", hl.dsp.focus({ last = true }),                                            { desc = "focus last window" })

hl.bind(mainMod .. " + Z",         hl.dsp.exec_cmd(scripts .. "/zoom.sh --more"),                    { desc = "zoom in" })
hl.bind(mainMod .. " + ALT + Z",   hl.dsp.exec_cmd(scripts .. "/zoom.sh --less"),                    { desc = "zoom out" })
hl.bind(mainMod .. " + SHIFT + Z", hl.dsp.exec_cmd(scripts .. "/zoom.sh --reset"),                   { desc = "zoom reset" })

hl.bind(mainMod .. " + code:21", hl.dsp.exec_cmd("qalculate-qt"),                                    { desc = "calculator" })

hl.bind(mainMod .. " + SPACE",         hl.dsp.window.move({ out_of_group = true}),                   { desc = "move out of group" })
hl.bind(mainMod .. " + SPACE",         hl.dsp.window.float({ action = "toggle" }),                   { desc = "toggle float" })

hl.bind(mainMod .. " + SHIFT + SPACE", hl.dsp.window.center(),                                       { desc = "center window" })

-- focus navigation

hl.bind(mainMod .. " + h",  hl.dsp.focus({ direction = "left" }),          { desc = "focus left" })
hl.bind(mainMod .. " + l",  hl.dsp.focus({ direction = "right" }),         { desc = "focus right" })
hl.bind(mainMod .. " + k",  hl.dsp.focus({ direction = "up" }),            { desc = "focus up" })
hl.bind(mainMod .. " + j",  hl.dsp.focus({ direction = "down" }),          { desc = "focus down" })

hl.bind(mainMod .. " + SHIFT + h",  hl.dsp.window.move({direction = "left"}),   { desc = "move window left" })
hl.bind(mainMod .. " + SHIFT + l",  hl.dsp.window.move({ direction = "right" }), { desc = "move window right" })
hl.bind(mainMod .. " + SHIFT + k",  hl.dsp.window.move({ direction = "up" }),   { desc = "move window up" })
hl.bind(mainMod .. " + SHIFT + j",  hl.dsp.window.move({ direction = "down" }), { desc = "move window down" })

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true, desc = "move window" })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true, desc = "resize window" })

-- submaps
hl.bind(mainMod .. " + ALT + R", hl.dsp.submap("resize"), { desc = "open submap: resize" })
hl.bind(mainMod .. " + N",       hl.dsp.submap("notes"),  { desc = "open submap: notes" })
hl.bind(mainMod .. " + PERIOD",  hl.dsp.submap("tools"),  { desc = "open submap: tools" })

-- multimedia
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"),                        { locked = true, desc = "play/pause" })
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),                              { locked = true, desc = "next track" })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),                          { locked = true, desc = "prev track" })
hl.bind("XF86AudioStop",  hl.dsp.exec_cmd("playerctl --all-players stop"),                { locked = true, desc = "stop" })
hl.bind("XF86AudioMute",  hl.dsp.exec_cmd("pactl set-source-mute @DEFAULT_SOURCE@ toggle"), { locked = true, desc = "toggle mic mute" })
hl.bind("XF86Eject",      hl.dsp.exec_cmd("amixer set Master toggle"),                    { locked = true, desc = "toggle speaker mute" })

-- workspaces
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + ALT + " .. key,   hl.dsp.exec_cmd("qs ipc call windows focus ".. key), { desc = "focus grouped window " .. key })
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i}),                       { desc = "focus workspace " .. i })
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i, follow = false}), { desc = "move to workspace " .. i })
end