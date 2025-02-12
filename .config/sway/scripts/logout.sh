#!/bin/bash
#
# Modified from sway's locking script
# TODO: remove bashism

if [[ ! $(which swayidle 2>/dev/null) ]]; then
	notify-send "ERROR" "Swayidle not found"
	exit 1
fi

choices=("suspend" "poweroff" "reboot" "lock")
choice=$(printf "%s\n" "${choices[@]}" | fuzzel -d --prompt "🔌: ")

if test "$choice" = lock; then
	$(dirname $0)/lock.sh
elif test -n "$choice"; then
	systemctl $choice
fi
