local function once(process, command)
    local start = "if command -v uwsm >/dev/null 2>&1 && uwsm check is-active >/dev/null 2>&1; then uwsm app -- " .. command .. "; else " .. command .. "; fi"
    hl.exec_cmd("sh -c 'command -v " .. process .. " >/dev/null 2>&1 && { pgrep -x " .. process .. " >/dev/null || " .. start .. "; }'")
end

local function once_plain_session(process, command)
    hl.exec_cmd("sh -c 'if command -v uwsm >/dev/null 2>&1 && uwsm check is-active >/dev/null 2>&1; then exit 0; fi; command -v " .. process .. " >/dev/null 2>&1 && { pgrep -x " .. process .. " >/dev/null || " .. command .. "; }'")
end

hl.on("hyprland.start", function ()
    hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme prefer-dark")
    hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-theme Adwaita-dark")
    once("hyprpaper", "hyprpaper -c ~/.config/hypr/ecosystem/hyprpaper.conf")
    once("hypridle", "hypridle")
    once("hyprsunset", "hyprsunset")
    once("mako", "mako")
    once("battery-watch", "battery-watch")
    once_plain_session("waybar", "waybar")
end)
