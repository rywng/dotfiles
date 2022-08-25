#!/bin/sh

if pactl get-sink-mute @DEFAULT_SINK@ | grep -q "yes"
then
  echo "0"
else
  pactl get-sink-volume @DEFAULT_SINK@ | head -n 1 | awk '{print substr($5, 1, length($5)-1)}'
fi
