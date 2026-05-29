local function once(process, command)
    local start = "if command -v uwsm >/dev/null 2>&1 && uwsm check is-active >/dev/null 2>&1; then uwsm app -- " .. command .. "; else " .. command .. "; fi"
    hl.exec_cmd("sh -c 'command -v " .. process .. " >/dev/null 2>&1 && { pgrep -x " .. process .. " >/dev/null || " .. start .. "; }'")
end

hl.on("hyprland.start", function ()
    once("hyprpaper", "hyprpaper -c ~/.config/hypr/ecosystem/hyprpaper.conf")
    once("hypridle", "hypridle")
    once("hyprsunset", "hyprsunset")
    once("waybar", "waybar")
end)
