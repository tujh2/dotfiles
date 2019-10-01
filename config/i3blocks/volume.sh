#!/bin/bash

if [[ "$(pamixer --get-mute)" == "true"  ]]; then 
	echo " <span foreground=\"#FF0000\">(muted)</span> $(pamixer --get-volume) %"
else echo "  $(pamixer --get-volume) %"
fi
