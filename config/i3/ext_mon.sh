#!/bin/bash

if [[ "$1" == "-p" ]]; then
	xrandr --output HDMI1 --mode 1920x1080 $2 eDP1
elif [[ "$1" == "-r" ]]; then
	xrandr --output HDMI1 --rotate $
elif [[ "$1" == "--off"  ]]; then
	xrandr --output HDMI1 --off
fi

killall compton; killall feh
compton --backend glx --blur-method kawase --blur-strength 5 --blur-background &
feh --bg-scale ~/Pictures/bg.jpg &
