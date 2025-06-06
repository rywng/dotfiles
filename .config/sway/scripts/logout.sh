#!/bin/bash
#
# Modified from sway's locking script
# TODO: remove bashism

if [[ ! $(which swayidle 2>/dev/null) ]]; then
	notify-send "ERROR" "Swayidle not found"
	exit 1
fi

choices=("suspend" "poweroff" "reboot" "lock" "lock and suspend")
choice=$(printf "%s\n" "${choices[@]}" | fuzzel -d --prompt "🔌: ")

if test "$choice" = lock; then
	$(dirname $0)/lock.sh
elif test "$choice" = "lock and suspend"; then
	$(dirname $0)/lock.sh &
	sleep 10s
	systemctl suspend
elif test -n "$choice"; then
	systemctl $choice
fi
