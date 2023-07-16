#!/bin/sh

SCRIPT_LOC=~/.config/sway/scripts/
FOLDER=~/Pictures/Screenshots/
# FILE="/tmp/share/screenshots/`date +'%y%m%d%H%M.png'`"
FILE="$FOLDER`date +'%y%m%d%H%M.png'`"

action=`echo -e "copy\nsave" | wofi -d -Oalphabetical --prompt="Select your action"`
target=`echo -e "active\nscreen\noutput\narea\nwindow" | wofi -d -Oalphabetical --prompt="Select the target"`

test $action || exit
test $target || exit

# test -d /tmp/share/screenshot || mkdir -p /tmp/share/screenshots

~/.config/sway/scripts/grimshot.sh --notify $action $target $FILE

if [ $target = "active" ] || [ $target = "window" ] || [ $target = "area" ]
then
	$SCRIPT_LOC/boxshadow.sh "$FILE" "$FILE" || die "Unable to save screenshot"
	echo -e "saved file"
fi
