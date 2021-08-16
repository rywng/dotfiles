#!/bin/sh

choice=`echo "shutdown\npoweroff\nreboot\nlock" | wofi -d -Oalphabetical`
if test "$choice" = lock ; then
  tmp=/tmp/lockscreen.bmp
  grim - | magick - -blur 0x6 $tmp
  bright=`light`
  swayidle -w \
    timeout 5 "light -S 1" resume "light -S $bright" \
    timeout 10 'swaymsg "output * dpms off"' resume 'swaymsg "output * dpms on"' \
    &
  idlepid=$!
  swaylock -e -i $tmp -c 000000 --inside-color 00000003
  kill $idlepid
  rm $tmp
  swaymsg "output * dpms on"
  light -S $bright
  return 0
fi
loginctl $choice
