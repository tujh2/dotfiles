#!/bin/bash
if [[ -d "/proc/sys/net/ipv4/conf/wg0" ]]; then 
	pkexec wg-quick down wg0
else pkexec wg-quick up wg0
fi
