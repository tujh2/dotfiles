#!/bin/bash
dunst &
feh --bg-scale ~/Pictures/bg.jpg &
betterlockscreen -w dim &
compton --backend glx --blur-method kawase --blur-strength 5 --blur-background &
#exec --no-startup-id nm-applet
#exec --no-startup-id cmst -m
setxkbmap -layout "us,ru" -option "grp:caps_toggle,grp_led:caps" &
