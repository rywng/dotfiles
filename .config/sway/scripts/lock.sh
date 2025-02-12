#!/bin/sh

set -e

playerctl stop || true

bright=$(xbacklight -get)

flock ~/.config/sway/locks/swayidle echo Successfully acquired lock

swayidle -w \
	timeout 5 "xbacklight -set 0" resume "xbacklight -set $bright" \
	timeout 10 'swaymsg "output * power off"' resume 'swaymsg "output * power on"' &

idlepid=$!

flock ~/.config/sway/locks/swaylock swaylock

kill $idlepid
swaymsg "output * power on"
xbacklight -set $bright
