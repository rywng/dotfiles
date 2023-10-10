#!/bin/sh

choice=`echo -e "suspend\nshutdown\npoweroff\nreboot\nlock" | wofi -d --prompt "󰚥 Choose power option" -Oalphabetical`
if test "$choice" = lock ; then
    bright=`light`
    swayidle -w \
        timeout 5 "light -S 1" resume "light -S $bright" \
        timeout 10 'swaymsg "output * power off"' resume 'swaymsg "output * power on"' \
        &
    idlepid=$!
    swaylock -e -c 282828 --inside-color 00000003
    kill $idlepid
    swaymsg "output * power on"
    light -S $bright
else
    loginctl $choice
fi
