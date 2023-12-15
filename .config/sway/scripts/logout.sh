#!/bin/sh
#
# Modified from sway's locking script


if [[ ! $(which swayidle 2> /dev/null) ]]; then
    notify-send "ERROR" "Swayidle not found"
    exit 1
fi

choice=$(echo -e "suspend\nshutdown\npoweroff\nreboot\nlock" | wofi -d --prompt "󰚥 Choose power option" -Oalphabetical)


if test "$choice" = lock ; then
    # sleep less when power on
    if acpi -a | grep -q on; then
        sleep_time=3600
    else
        sleep_time=10
    fi
    sleep 0.3

    bright=`light`

    swayidle -w \
        timeout 5 "light -S 1" resume "light -S $bright" \
        timeout $sleep_time 'swaymsg "output * power off"' resume 'swaymsg "output * power on"' \
        &
    idlepid=$!
    swaylock -e -c 282828 --inside-color 00000003
    kill $idlepid
    swaymsg "output * power on"
    light -S $bright
elif test -n "$choice"; then
    systemctl $choice
fi
