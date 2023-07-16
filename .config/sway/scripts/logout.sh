#!/bin/sh

choice=`echo -e "suspend\nshutdown\npoweroff\nreboot\nlock\nhibernate" | wofi -d -Oalphabetical`
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
  return 0
fi
loginctl $choice
