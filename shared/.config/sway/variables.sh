set $mod Mod4
set $left h
set $down j
set $up k
set $right l

set $term ghostty
set $menu wmenu-run
set $browser firefox

set $screenshot grim -g "$(slurp -d)" - | wl-copy -t image/png

set $killsway swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -B 'Yes, exit sway' 'swaymsg exit'
set $restartwaybar killall waybar && waybar
set $swaylock swaylock --clock --effect-blur 5x10 --indicator --timestr "%-H:%M" --datestr "Locked"
