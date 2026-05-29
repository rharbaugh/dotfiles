-- Main Hyprland entrypoint. Keep feature work in the focused modules below.

local config_home = os.getenv("XDG_CONFIG_HOME") or (os.getenv("HOME") .. "/.config")
package.path = config_home .. "/hypr/lua/?.lua;" .. package.path

require("settings")
require("outputs")
require("env")
require("autostart")
require("look")
require("inputs")
require("layouts")
require("binds")
require("rules")
