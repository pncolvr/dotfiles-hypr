local home = os.getenv("HOME")
local scripts = home .. "/.config/hypr/scripts"
local rofi    = home .. "/.config/rofi/scripts"

local mainMod = "SUPER"
-- general
hl.bind(mainMod .. " + SHIFT + PERIOD",  hl.dsp.exec_cmd(scripts .. "/directory/books-pick.sh --pick"))
hl.bind(mainMod .. " + SHIFT + SLASH",   hl.dsp.exec_cmd("ghostty --title=Keybinds -e " .. scripts .. "/keybinds/display.sh --keybinds"))
hl.bind(mainMod .. " + SHIFT + A",       hl.dsp.exec_cmd(rofi ..    "/web/azure.sh --pick"))

hl.bind(mainMod .. " + B",         hl.dsp.exec_cmd(scripts .. "/browser/openbookmarks.sh"))
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd("xdg-open https://www.monday.com"))

hl.bind(mainMod .. " + D",         hl.dsp.exec_cmd("rofi -show drun"))
hl.bind(mainMod .. " + SHIFT + D", hl.dsp.exec_cmd(rofi .. "/remotes/pick.sh"))

hl.bind(mainMod .. " + E",         hl.dsp.exec_cmd(rofi .. "/web/webapps.sh"))

hl.bind(mainMod .. " + ESCAPE",                 hl.dsp.exec_cmd(scripts .. "/powermenu.sh"))
hl.bind(mainMod .. " + SHIFT + ESCAPE",         hl.dsp.exec_cmd("qs ipc call notifications toggle"))

hl.bind(mainMod .. " + F",         hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle"}))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle"}))

hl.bind(mainMod .. " + G",         hl.dsp.exec_cmd(rofi .. "/web/github.sh"))

hl.bind(mainMod .. " + I",         hl.dsp.exec_cmd(scripts .. "/tolocalplayer.sh"))
hl.bind(mainMod .. " + SHIFT + I", hl.dsp.exec_cmd(scripts .. "$scripts/rnd.sh " .. home .. "/Pictures/streamers/"))

hl.bind(mainMod .. " + M",         hl.dsp.exec_cmd(scripts .. "/toggle/noscreenshare.sh"))

hl.bind(mainMod .. " + SHIFT + N", hl.dsp.exec_cmd(rofi .. "/web/n8n.sh"))

hl.bind(mainMod .. " + P",         hl.dsp.exec_cmd(rofi .. "/code.sh"))

hl.bind(mainMod .. " + PRINT",     hl.dsp.exec_cmd(scripts .. "/screen/shot.sh"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd(scripts .. "/screen/shot.sh region"))
hl.bind(mainMod .. " + SHIFT + PRINT", hl.dsp.exec_cmd(scripts .. "/screen/shot.sh window"))
hl.bind("PRINT", hl.dsp.exec_cmd(scripts .. "/screen/shot.sh output"))

hl.bind(mainMod .. " + Q",         hl.dsp.exec_cmd("hyprctl kill") )
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.close())

hl.bind(mainMod .. " + R",         hl.dsp.exec_cmd(scripts .. "/screen/capture.sh"))
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd(scripts .. "/reload.sh"))

hl.bind(mainMod .. " + RETURN",         hl.dsp.exec_cmd(scripts .. "/toggle/terminal.sh"))
hl.bind(mainMod .. " + SHIFT + RETURN", hl.dsp.exec_cmd("ghostty"))

hl.bind(mainMod .. " + T",         hl.dsp.exec_cmd(scripts .. "/directory/pick.sh"))

hl.bind("ALT + TAB",         hl.dsp.exec_cmd(rofi .. "/windows/any.sh"))
hl.bind("ALT + SHIFT + TAB", hl.dsp.exec_cmd(rofi .. "/windows/currentworkspace.sh"))

hl.bind(mainMod .. " + TAB",         hl.dsp.exec_cmd("qs ipc call windows next"))
hl.bind(mainMod .. " + SHIFT + TAB", hl.dsp.exec_cmd("qs ipc call windows prev"))

hl.bind(mainMod .. " + U",         hl.dsp.focus({ urgent_or_last = true }))

hl.bind(mainMod .. " + V",         hl.dsp.exec_cmd("copyq show"))

hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("ghostty --title=passwords -e ".. home .."/Projects/helpers/totp/handler.sh"))

hl.bind(mainMod .. " + X",         hl.dsp.exec_cmd(scripts .. "/toggle/animations.sh"))

hl.bind(mainMod .. " + Y", hl.dsp.focus({ last = true }))

hl.bind(mainMod .. " + Z",         hl.dsp.exec_cmd(scripts .. "/zoom.sh --more"))
hl.bind(mainMod .. " + ALT + Z",   hl.dsp.exec_cmd(scripts .. "/zoom.sh --less"))
hl.bind(mainMod .. " + SHIFT + Z", hl.dsp.exec_cmd(scripts .. "/zoom.sh --reset"))

hl.bind(mainMod .. " + code:21", hl.dsp.exec_cmd("qalculate-qt"))

hl.bind(mainMod .. " + SPACE",         hl.dsp.window.move({ out_of_group = true}))
hl.bind(mainMod .. " + SPACE",         hl.dsp.window.float({ action = "toggle" }))

hl.bind(mainMod .. " + SHIFT + SPACE", hl.dsp.window.center())

-- focus navigation

hl.bind(mainMod .. " + h",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + l",  hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + k",  hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + j",  hl.dsp.focus({ direction = "down" }))

hl.bind(mainMod .. " + SHIFT + h",  hl.dsp.window.move({direction = "left"}))
hl.bind(mainMod .. " + SHIFT + l",  hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + k",  hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + j",  hl.dsp.window.move({ direction = "down" }))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true } )
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true } )

-- submaps
hl.bind(mainMod .. " + ALT + R", hl.dsp.submap("resize"))
hl.bind(mainMod .. " + N",       hl.dsp.submap("notes"))
hl.bind(mainMod .. " + PERIOD",  hl.dsp.submap("tools"))

-- multimedia
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })
hl.bind("XF86AudioStop",  hl.dsp.exec_cmd("playerctl --all-players stop"),   { locked = true })

hl.bind("XF86AudioMute",  hl.dsp.exec_cmd("pactl set-source-mute @DEFAULT_SOURCE@ toggle"),   { locked = true })
hl.bind("XF86Eject", hl.dsp.exec_cmd("amixer set Master toggle"), { locked = true })

-- workspaces
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + ALT + " .. key, hl.dsp.exec_cmd("qs ipc call windows focus ".. key))
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i, follow = false}))
end