#!/bin/bash

WP_PATH="/home/tujh/git/wallpapers/"
DEFAULT_UPDATE_TIME=1800

function updateWallpaper {
	image=$(ls $WP_PATH | grep -E '(jpg|png)$' | sort -R | tail -1)
	feh --bg-scale $WP_PATH/$image
}

while true
do
	updateWallpaper
	sleep $DEFAULT_UPDATE_TIME
done
