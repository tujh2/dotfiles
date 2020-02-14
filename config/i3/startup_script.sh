#!/bin/bash
xss-lock -- i3lock -i ~/Pictures/bg.png &
dunst &
feh --bg-scale ~/Pictures/bg.png &
picom &
setxkbmap -layout "us,ru" -option "grp:caps_toggle,grp_led:caps" &
lxqt-policykit-agent &
