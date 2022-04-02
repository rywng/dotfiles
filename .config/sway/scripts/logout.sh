#!/bin/sh

choice=`echo "suspend\nshutdown\npoweroff\nreboot\nlock" | wofi -d -Oalphabetical`
if test "$choice" = lock ; then
  bright=`light`
  swayidle -w \
    timeout 5 "light -S 1" resume "light -S $bright" \
    timeout 10 'swaymsg "output * dpms off"' resume 'swaymsg "output * dpms on"' \
    &
  idlepid=$!
  swaylock -e -c 2a2f33 --inside-color 00000003
  kill $idlepid
  swaymsg "output * dpms on"
  light -S $bright
  return 0
fi
loginctl $choice
