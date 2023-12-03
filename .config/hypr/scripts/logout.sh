#!/bin/sh
#
# Modified from sway's locking script


if [[ ! $(which swayidle 2> /dev/null) ]]; then
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
    # swaylock -e -c 282828 --inside-color 00000003
    swaylock -S --effect-blur "5x5" --effect-vignette 0.5:0.5 --inside-color 00000003 \
        -e --ring-color 00000005 --line-color 00000035
    kill $idlepid
    hyprctl dispatch dpms on
    light -S $bright
elif test -n "$choice"; then
    loginctl $choice
fi
