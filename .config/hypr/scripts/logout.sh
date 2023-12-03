#!/bin/sh
#
# Modified from sway's locking script


if [[ ! -e /bin/swayidle ]]; then
	notify-send "ERROR" "Swayidle not found"
	exit 1
fi

choice=`echo -e "suspend\nshutdown\npoweroff\nreboot\nlock" | wofi -d --prompt "󰚥 Choose power option" -Oalphabetical`
if test "$choice" = lock ; then
    bright=`light`
    swayidle -w \
        timeout 5 "light -S 1" resume "light -S $bright" \
        timeout 10 'hyprctl dispatch dpms off' resume 'hyprctl dispatch dpms on' \
        &
    idlepid=$!
    swaylock -e -c 282828 --inside-color 00000003
    kill $idlepid
    hyprctl dispatch dpms on
    light -S $bright
else
    loginctl $choice
fi
