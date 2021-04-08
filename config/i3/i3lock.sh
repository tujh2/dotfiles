#!/bin/bash
WP_PATH="/home/tujh/git/wallpapers/"
DEFAULT_UPDATE_TIME=1800

image=$(ls $WP_PATH | grep -E '(jpg|png)$' | sort -R | tail -1)
convert "$WP_PATH$image" -resize 1920x1080 RGB:- | \
	i3lock \
		-p default \
		--raw 1920x1080:rgb \
		-fi /dev/stdin \
		--force-clock --timecolor=FFC0C0FF --datecolor=FFC0C0FF --datestr="%d.%m.%Y" \
		--time-font=Hack --timesize=26 \
		--date-font=Hack --datesize=24 \
		-t
