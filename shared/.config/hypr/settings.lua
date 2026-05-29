local settings = {}

settings.terminal = "ghostty"
settings.file_manager = settings.terminal .. " -e yazi"
settings.launcher = "command -v walker >/dev/null 2>&1 && walker || hyprlauncher"

function settings.tui(command, title)
    if title == nil then
        return settings.terminal .. " -e " .. command
    end

    return settings.terminal .. " -e sh -lc 'printf \"\\033]2;" .. title .. "\\007\"; exec " .. command .. "'"
end

return settings
