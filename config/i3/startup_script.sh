#!/bin/bash
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK
xss-lock -l -- ~/.config/i3/i3lock.sh &
dunst &
~/.config/i3/wallpapers.sh &
picom &
setxkbmap -layout "us,ru" -option "grp:caps_toggle,grp_led:caps" &
lxqt-policykit-agent &
