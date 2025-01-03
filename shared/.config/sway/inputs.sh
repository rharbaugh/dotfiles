#man 5 sway-input for kb/mouse stuff
#swaymsg -t get_inputs
### mouse
focus_follows_mouse no
input "type:pointer" {
    accel_profile "flat"
}

### keyboard
input "type:keyboard" {
    repeat_delay 400
    repeat_rate 40
}

