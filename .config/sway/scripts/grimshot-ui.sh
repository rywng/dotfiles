#!/bin/sh

SCRIPT_LOC=~/.config/sway/scripts/
FILE="/tmp/share/screenshots/`date +'%y%m%d%H%M.png'`"

action=`echo "copy\nsave" | wofi -d -Oalphabetical --prompt="Select your action"`
target=`echo "active\nscreen\noutput\narea\nwindow" | wofi -d -Oalphabetical --prompt="Select the target"`

test $action || exit
test $target || exit

test -d /tmp/share/screenshot || mkdir -p /tmp/share/screenshots

# TODO, add box shadows

XDG_SCREENSHOTS_DIR=/tmp/share/screenshots ~/.config/sway/scripts/grimshot.sh --notify $action $target $FILE

if [ $target = "active" ] || [ $target = "window" ] || [ $target = "area" ]
then
	$SCRIPT_LOC/boxshadow.sh "$FILE" "$FILE" || die "Unable to save screenshot"
	echo "saved file"
fi
