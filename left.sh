#!/bin/bash
xrandr -o left
xinput set-prop "ELAN Touchscreen" --type=float "Coordinate Transformation Matrix" 0 -1 1 1 0 0 0 0 1
killall compton && compton
