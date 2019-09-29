#!/bin/bash
if [ $(nmcli r wifi)  == 'enabled' ]
then
	nmcli r wifi off
else
	nmcli r wifi on 
fi
