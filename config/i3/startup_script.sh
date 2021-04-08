#!/bin/bash
xss-lock -- sh ~/.config/i3/i3lock.sh &
dunst &
~/.config/i3/wallpapers.sh &
picom &
setxkbmap -layout "us,ru" -option "grp:caps_toggle,grp_led:caps" &
lxqt-policykit-agent &
