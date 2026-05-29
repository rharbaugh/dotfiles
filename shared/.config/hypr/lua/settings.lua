local settings = {}

settings.terminal = "ghostty"
settings.file_manager = settings.terminal .. " -e yazi"
settings.launcher = "walker"

function settings.tui(command, title)
    if title == nil then
        return settings.terminal .. " -e " .. command
    end

    return "dotfiles-popup " .. title .. " " .. command
end

return settings
