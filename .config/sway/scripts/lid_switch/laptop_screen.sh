#!/bin/sh

# Disable and enable laptop screen only when external monitors found
monitor_count=$(swaymsg -t get_outputs | grep name | wc -l)
laptop_output="eDP-1"

if [ $monitor_count -gt 1 ]; then
	case "$1" in
	disable)
		swaymsg output $laptop_output disable
		;;
	enable)
		swaymsg output $laptop_output enable
		;;
	*)
		echo "Invalid argument"
		;;
	esac
fi
