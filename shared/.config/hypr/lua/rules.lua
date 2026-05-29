hl.window_rule({
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})

hl.window_rule({
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})

hl.window_rule({
    name  = "float-tui-popups",
    match = { title = "^(Bluetooth|Wi-Fi|Activity)$" },

    float = true,
    size  = "80% 80%",
})

hl.window_rule({
    name  = "float-power-menu",
    match = { title = "^Power$" },

    float = true,
    size  = "360 300",
})

hl.layer_rule({
    name  = "walker-blur",
    match = { namespace = "^walker$" },
    blur  = true,
})
