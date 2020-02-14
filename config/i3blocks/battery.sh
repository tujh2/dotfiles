#!/bin/bash
bat_path="/sys/class/power_supply/BAT0/"
bat_status=$(cat $bat_path/status)
bat_now=$(cat $bat_path/capacity)
charge_now=$(cat $bat_path/charge_now)
charge_full=$(cat $bat_path/charge_full)

if [[ "$bat_status" == "Discharging" ]]; then
	current_now=$(cat $bat_path/current_now)
	let "seconds = 3600*$charge_now / $current_now"
	hours=$(expr $seconds / 3600)
	let "minutes = ($seconds - hours*3600)/60"
	
	if [[ "$bat_now"  -lt "20" ]]; then
		echo "  <span foreground=\"#FF0000\">$bat_now %</span> $hours:$minutes"
	elif [[ "$bat_now" -lt "40" ]]; then 
		echo "  <span foreground=\"#FFAE00\">$bat_now %</span> $hours:$minutes"
	elif [[ "$bat_now" -lt "60"  ]]; then
		echo "  <span foreground=\"#FFF600\">$bat_now %</span> $hours:$minutes"
	elif [[ "$bat_now" -lt "85" ]]; then 
		echo "  <span foreground=\"#A8FF00\">$bat_now %</span> $hours:$minutes"
	else 
		echo "  <span foreground=\"#00FF00\">$bat_now %</span> $hours:$minutes"
	fi
elif [[ "$bat_status" == "Charging" ]]; then
	current_now=$(cat $bat_path/current_now)
	let "seconds = 3600*($charge_full - $charge_now) / $current_now"
	hours=$(expr $seconds / 3600)
	let "minutes = ($seconds - hours*3600)/60"
	echo " <span foreground=\"#00FF00\">$bat_now %</span> $hours:$minutes"
elif [[ "$bat_status" == "Full"  ]]; then
	echo " <span foreground=\"#00FF00\">FULL</span>"
else
	echo " <span foreground=\"#FFAE00\">UNKNOWN</span>"
fi
