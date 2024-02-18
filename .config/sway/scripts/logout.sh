#!/bin/bash
#
# Modified from sway's locking script


if [[ ! $(which swayidle 2> /dev/null) ]]; then
    notify-send "ERROR" "Swayidle not found"
    exit 1
fi

choices=("suspend" "poweroff" "reboot" "lock")
choice=$(printf "%s\n" "${choices[@]}" | fuzzel -d --prompt "󰚥: ")


if test "$choice" = lock ; then
    # sleep less when power on
    # if acpi -a | grep -q on; then
    #     sleep_time=3600
    # else
    #     sleep_time=10
    # fi
    sleep_time=10
    sleep 0.3

    bright=`light`

    swayidle -w \
        timeout 5 "light -S 1" resume "light -S $bright" \
        timeout $sleep_time 'swaymsg "output * power off"' resume 'swaymsg "output * power on"' \
        &
    idlepid=$!

    # swaylock -e -c 282828 --inside-color 00000003
    swaylock -S --effect-blur "12x12" --effect-greyscale --effect-vignette 0.5:0.5 --inside-color 28282860 \
        -e --ring-color 00000000 --line-color 00000000 --indicator --clock --text-color ebdbb2

    kill $idlepid
    swaymsg "output * power on"
    light -S $bright
elif test -n "$choice"; then
    systemctl $choice
fi
