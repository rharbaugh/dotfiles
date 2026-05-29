local function once(process, command)
    hl.exec_cmd("sh -c 'command -v " .. process .. " >/dev/null 2>&1 && { pgrep -x " .. process .. " >/dev/null || " .. command .. "; }'")
end

hl.on("hyprland.start", function ()
    once("hyprpaper", "hyprpaper")
    once("hypridle", "hypridle")
    once("hyprsunset", "hyprsunset")
    once("waybar", "waybar")
end)
