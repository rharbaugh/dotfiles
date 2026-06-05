-- Generic output fallback. Profile packages may add a profile_outputs.lua
-- module for machine-specific monitor rules.

hl.monitor({
    output   = "",
    mode     = "highres@highrr",
    position = "auto",
    scale    = "auto",
})
