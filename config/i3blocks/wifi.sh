#!/bin/bash

if [[ "$(nmcli r wifi)"  == "disabled" ]]; then
	echo " <span foreground=\"#FF0000\">DOWN</span>"
else
	SSID=$(nmcli -m tabular -t -f GENERAL.CONNECTION d show wlp1s0)
	IP=$(nmcli -m tabular -t -f IP4.ADDRESS d show wlp1s0 | awk -F/ '{print $1}')
	QUALITY=$(grep wlp1s0 /proc/net/wireless | awk '{ print int($3 * 100 / 70) }')
	
	if [[ "$SSID" == "" ]]; then
		echo " <span foreground=\"#00FFFF\">NONE</span>"
	else
		echo " <span foreground=\"#00FF00\">($QUALITY% at $SSID)</span> <span foreground=\"#91E78B\">$IP</span>"
	fi
fi
