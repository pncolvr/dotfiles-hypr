-- see: https://wiki.hypr.land/Configuring/Start/
-- and: https://github.com/hyprwm/Hyprland/blob/main/example/hyprland.lua

package.path = os.getenv("HOME") .. "/.config/hypr/?.lua;" .. package.path

local theme = require("themes.mocha")

require("config.autostart")
require("config.env")
-- we can remove this line or add private env variables there
require("config.envprivate")
require("config.monitors")
require("config.submaps")
require("config.windowrules")
require("config.keybinds")


hl.config({
    general = {
        gaps_in = 1,
        gaps_out = 0,
        border_size = 2,

        col = {
            active_border = theme.activeColor,
            inactive_border = theme.inactiveColor,
        },
        layout = "dwindle",
        snap = {
            enabled = true
        }
    },
    misc = {
        disable_hyprland_logo = true,
        background_color = theme.inactiveColor,
        vrr = 0 -- 0 - off, 1 - on, 2 - fullscreen only, 3 - fullscreen with video or game content type
    },
    ecosystem = {
        no_donation_nag = true
    },
    group = {
        groupbar = {
            enabled = false,
            font_family = "JetBrainsMonoNL-Bold, sans-serif;",
            font_weight_active = "bold",
            font_weight_inactive = "semibold",
            col = {
                active = theme.activeColor,
                inactive = theme.inactiveColor,
                locked_active = theme.inactiveColor,
                locked_inactive = theme.inactiveColor,
            },
            indicator_gap = 0,
            indicator_height = 0,
            font_size = 14,
            render_titles = true,
            keep_upper_gap = true,
            gaps_out = 0,
            gaps_in = 0,
            stacked = false,
            gradients = true,
            text_color = theme.inactiveColor,
            text_color_inactive = theme.text,
        },
        insert_after_current = false,
        col = {
            border_active = theme.activeColor,
            border_inactive = theme.inactiveColor,
            border_locked_active = theme.inactiveColor,
            border_locked_inactive = theme.inactiveColor
        }
    },
    decoration = {
        rounding = 0,
        blur = { 
            enabled = false
        },
        active_opacity = 1.0,
        inactive_opacity = 1.0,
        fullscreen_opacity = 1.0
    },
    animations = {
        enabled = true
    },
    dwindle = {
        preserve_split = true,
        force_split = 2
    },
    master = {
        mfact = 0.85,
    },
    input = {
        kb_layout = "us",
        kb_variant = "intl",
        force_no_accel = true,
        follow_mouse = 1,
        touchpad = {
            natural_scroll = false,
        },
        sensitivity = 0
    }
})

-- Default curves and animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })

-- Default springs
hl.curve("easy",           { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })

hl.animation({ leaf = "global",        enabled = true,  speed = 1,   bezier = "default" })
-- hl.animation({ leaf = "border",        enabled = true,  speed = 5.39, bezier = "easeOutQuint" })
-- hl.animation({ leaf = "windows",       enabled = true,  speed = 4.79, spring = "easy" })
-- hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 4.1,  spring = "easy",         style = "popin 87%" })
-- hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 1.49, bezier = "linear",       style = "popin 87%" })
-- hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 1.73, bezier = "almostLinear" })
-- hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 1.46, bezier = "almostLinear" })
-- hl.animation({ leaf = "fade",          enabled = true,  speed = 3.03, bezier = "quick" })
-- hl.animation({ leaf = "layers",        enabled = true,  speed = 3.81, bezier = "easeOutQuint" })
-- hl.animation({ leaf = "layersIn",      enabled = true,  speed = 4,    bezier = "easeOutQuint", style = "fade" })
-- hl.animation({ leaf = "layersOut",     enabled = true,  speed = 1.5,  bezier = "linear",       style = "fade" })
-- hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 1.79, bezier = "almostLinear" })
-- hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 1.39, bezier = "almostLinear" })
-- hl.animation({ leaf = "workspaces",    enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
-- hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 1.21, bezier = "almostLinear", style = "fade" })
-- hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor",    enabled = true,  speed = 3,    bezier = "quick" })
