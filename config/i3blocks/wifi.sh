#!/bin/bash

if [[ "$(nmcli r wifi)"  == "disabled" ]]; then
	echo " <span foreground=\"#FF0000\">OFF</span>"
else
	SSID=$(nmcli -m tabular -t -f GENERAL.CONNECTION d show wlp1s0)
	IP=$(nmcli -m tabular -t -f IP4.ADDRESS d show wlp1s0 | awk -F/ '{print $1}')	
	if [[ "$SSID" == "" ]]; then
		echo " <span foreground=\"#00FFFF\">NONE</span>"
	else
		echo " <span foreground=\"#00FF00\">$SSID</span> ($IP)"
	fi
fi
