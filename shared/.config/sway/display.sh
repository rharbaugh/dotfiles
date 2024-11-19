# You can get the names of your outputs by running: swaymsg -t get_outputs
# man 5 sway-output
output DP-1 resolution 3440x1440@143.975Hz bg #1d2021 solid_color

exec swayidle -w \
  timeout 600 'swaylock -f -c 000000' \
  timeout 900 'swaymsg "output * power off"' resume 'swaymsg "output * power on"' \
  before-sleep 'swaylock -f -c 000000'
