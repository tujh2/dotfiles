#!/bin/bash
bat_status=$(cat /sys/class/power_supply/BAT0//uevent | grep -oP 'POWER_SUPPLY_STATUS=\K\w+')
bat_now=$(cat /sys/class/power_supply/BAT0//uevent | grep -oP 'POWER_SUPPLY_CAPACITY=\K\w+')


if [[ "$bat_status" == "Discharging" ]]; then
	if [[ "$bat_now"  -lt "20" ]]; then
		echo "<span foreground=\"#FF0000\">  </span> $bat_now %"
	elif [[ "$bat_now" -lt "40" ]]; then 
		echo "<span foreground=\"#FFAE00\">  </span> $bat_now %"
	elif [[ "$bat_now" -lt "60"  ]]; then
		echo "<span foreground=\"#FFF600\">  </span> $bat_now %"
	elif [[ "$bat_now" -lt "85" ]]; then 
		echo "<span foreground=\"#A8FF00\">  </span> $bat_now %"
	else 
		echo "<span foreground=\"#00FF00\">  </span> $bat_now %"
	fi
elif [[ "$bat_status" == "Charging" ]]; then
	echo " <span foreground=\"#00FF00\"> $bat_now %</span>"
elif [[ "$bat_status" == "Full"  ]]; then
	echo "  <span foreground=\"#00FF00\"> FULL</span>"
fi
