hl.config({
    cursor = {
        no_warps = true,
        warp_on_change_workspace = 0,
        warp_on_toggle_special = 0,
    },

    input = {
        kb_layout  = "us",
        kb_variant = "",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",
        repeat_rate  = 40,
        repeat_delay = 400,

        follow_mouse = 0,
        sensitivity  = 0,

        touchpad = {
            natural_scroll = false,
            disable_while_typing = true,
            clickfinger_behavior = true,
            tap_and_drag = true,
        },
    },
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})

hl.device({
    name          = "pixa3854:00-093a:0274-mouse",
    accel_profile = "flat",
    sensitivity   = 0,
})
