#!/bin/bash

if [[ -d  /proc/sys/net/ipv4/conf/wg0 ]]; then
	echo " YES"
	echo " YES"
	echo "#00FF00"
else
	echo " DOWN"
	echo " DOWN"
	echo " #FF0000"
fi

