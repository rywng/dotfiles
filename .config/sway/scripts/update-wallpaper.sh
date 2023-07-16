#!/bin/sh

export PATH="${PATH}:${HOME}/.local/bin"
export XDG_RUNTIME_DIR=/run/user/1000
export XDG_CACHE_HOME=$HOME/.cache

# If not using sway, we exit
if ! pidof sway > /dev/null
then
    exit
fi

# If the deamon starts first time, we only init it, and the wallpaper will be updated
if ! pidof swww-daemon > /dev/null
then
    swww init
    exit
fi

swww img $(find -L ~/.config/sway/Wallpaper/ -type f | shuf -n1) -t wave --transition-fps 60 --transition-duration 5 --transition-wave 16,16
