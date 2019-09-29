#!/bin/bash
dunst &
feh --bg-scale ~/Pictures/bg.jpg &
betterlockscreen -w dim &
compton &
setxkbmap -layout "us,ru" -option "grp:caps_toggle,grp_led:caps" &
lxqt-policykit-agent &
