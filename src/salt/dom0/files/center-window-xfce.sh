#!/bin/sh
# vim: set st=2 sw=2 et sts number:
set -xeuo pipefail

IFS='x' read display_width display_height < <(xrandr | grep " connected"  | grep -o '[0-9]\+x[0-9]\+')

window_width=$(xdotool getactivewindow getwindowgeometry --shell | grep -E "WIDTH" | grep -o '[0-9]\+')
window_height=$(xdotool getactivewindow getwindowgeometry --shell | grep -E "HEIGHT" | grep -o '[0-9]\+')

# panel_1_height=$(xfconf-query -c xfce4-panel -p /panels/panel-1 -lv | grep size | grep -o "[0-9]\+" | tail -n1)
# panel_2_height=$(xfconf-query -c xfce4-panel -p /panels/panel-2 -lv | grep size | grep -o "[0-9]\+" | tail -n1)

new_pos_x=$((display_width/2 - window_width/2))
new_pos_y=$((display_height/2 - window_height/2))

xdotool getactivewindow windowmove "${new_pos_x}" "${new_pos_y}"
