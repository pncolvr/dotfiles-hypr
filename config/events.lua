local function if_floating_move_to_mouse(w)
    if not w.floating then return end

    local cursor_pos = hl.get_cursor_pos()
    if not cursor_pos then return end

    local window_width = w.size.x
    local window_height = w.size.y
    local monitor_width = w.monitor.width
    local monitor_height = w.monitor.height
    local monitor_x = w.monitor.x
    local monitor_y = w.monitor.y

    local position_x=cursor_pos.x - window_width / 2
    local position_y=cursor_pos.y - window_height / 2
    local min_x=monitor_x + 10
    local min_y=monitor_y + 35
    local max_x=monitor_x + monitor_width - window_width - 10
    local max_y=monitor_y + monitor_height - window_height - 10

    if position_x < min_x then position_x=min_x end
    if position_y < min_y then position_y=min_y end
    if position_x > max_x then position_x=max_x end
    if position_y > max_y then position_y=max_y end

    hl.dispatch(hl.dsp.window.move({ window = "address:" .. w.address, x = position_x, y = position_y, exact = true }))
end

local function if_parent_pinned_pin(w) 
    local previous_window = hl.get_last_window()
    if not previous_window then return end
    if not previous_window.pinned then return end
    hl.dispatch(hl.dsp.window.pin({ window = "address:" .. w.address }))
    -- hl.timer(function()
    -- end, {timeout = 300, type="oneshot"})

    -- hl.notification.create({
    --     text = tostring(w.pinned),
    --     timeout = 5000
    -- })
end

local function sleep(n)
  os.execute("sleep " .. tonumber(n))
end

local function is_empty(s)
  return s == nil or s == ''
end

-- local function try_kill_window_with_class_and_title(class, title)
--     local found = false
--     for i = 1,2 do
--         hl.get_windows()
--         local windows = hl.get_windows()
--         for _, win in ipairs(windows) do
--             if win.class == class and win.title:match("^" .. title) then
--                 found = true
--                 hl.dispatch(hl.dsp.window.close({ window = "address:" .. win.address}))
--                 break
--             end
--         end
--         if found then
--             break
--         else
--             sleep(0.05)
--         end
--     end
-- end
local function force_tile(w)
    hl.dispatch(hl.dsp.window.float({ action="disable", window = "address:" .. w.address }))
end

function Open_floating_note(path)
    local mon = hl.get_active_monitor()
    if not mon then return end

    Pending_floating_note = {
        workspace_id = hl.get_active_workspace().id,
        resize_x     = math.floor(mon.width * 0.25),
        resize_y     = math.floor(mon.height * 0.66),
        move_x       = math.floor(mon.width * 0.74),
        move_y       = math.floor(mon.height * 0.14),
        cursor_x     = math.floor(mon.width * 0.865),
        cursor_y     = math.floor(mon.height * 0.47),
    }
    hl.dispatch(hl.dsp.exec_cmd("code --new-window " .. path))
end

local windowOpen = {
    ["qutebrowser-twitch-chat"] = function(w)
        hl.dispatch(hl.dsp.focus({ window = "class:mpv-twitch" }))
    end,
    ["yad"] = function (w)
        if w.title == "qrencode" then
            if_floating_move_to_mouse(w)
        end
    end,
    ["code"] = function (w)
        if  Pending_floating_note then
            local d = Pending_floating_note
            Pending_floating_note = nil
            local addr = "address:" .. w.address
            hl.dispatch(hl.dsp.window.move({ out_of_group = true, window = addr }))
            hl.dispatch(hl.dsp.window.float({ action = "enable", window = addr }))
            hl.dispatch(hl.dsp.window.resize({ x = d.resize_x, y = d.resize_y, window = addr }))
            hl.dispatch(hl.dsp.window.move({ workspace = d.workspace_id, window = addr }))
            hl.dispatch(hl.dsp.window.move({ x = d.move_x, y = d.move_y, window = addr }))
            hl.dispatch(hl.dsp.window.pin({ window = addr }))
            hl.dispatch(hl.dsp.cursor.move({ x = d.cursor_x, y = d.cursor_y }))
        else
            if_parent_pinned_pin(w)
            if_floating_move_to_mouse(w)
        end
    end,
    ["discord"] = force_tile,
    ["com.freerdp.client.sdl3"] = force_tile
}


hl.on("window.urgent", function (w)
    hl.dispatch(hl.dsp.focus({  window = "address:" .. w.address  }))
end)

hl.on("screenshare.state", function (active, type, name)
    hl.config({animations = { enabled = not active}})
end)

hl.on("window.open", function(w)
    if windowOpen[w.class] then
        windowOpen[w.class](w)
    end
end)

function HideApplications (active)
    NotificationsHidden:set_enabled(active)
    CommAppsHidden:set_enabled(active)
    VaultHidden:set_enabled(active)
end

-- hl.on("config.reloaded", function ()
    
-- end)

-- hl.on("keybinds.submap", function(s)
--     if not is_empty(s) then
--         hl.dispatch(hl.dsp.exec_cmd("ghostty --title=Keybinds -e ~/.config/hypr/scripts/keybinds/display.sh --submap " .. s))
--     end
-- end)
