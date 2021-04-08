#!/bin/bash

if [[ "$1" == "-p" ]]; then
	xrandr --output HDMI1 --auto $2 eDP1
elif [[ "$1" == "-r" ]]; then
	xrandr --output HDMI1 --rotate $2
elif [[ "$1" == "--toggle"  ]]; then
	xrandr --listactivemonitors | grep $2 > /dev/null && xrandr --output $2 --off || xrandr --output $2 --auto
fi

xinput --map-to-output $(xinput list --id-only "ELAN Touchscreen") eDP1

killall feh
feh --bg-scale ~/Pictures/bg.png &
