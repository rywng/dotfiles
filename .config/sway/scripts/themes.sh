scheme=$(echo -e "light\ndark" | wofi -d -p "Select color scheme")

# simply subsitude dark and light
if [ $scheme = "light" ]; then
    notify-send "Toggling light color scheme"
    command="s/dark/light/"
elif [ $scheme = "dark" ]; then
    notify-send "Toggling dark color scheme"
    command="s/light/dark/"
else
    exit 1
fi

sed -i $command ~/.config/kitty/kitty.conf
sed -i $command ~/.config/sway/config.d/theme
sed -i $command ~/.config/swaync/style.css
sed -i $command ~/.config/waybar/style.css
sed -i $command ~/.config/wofi/config

swaync-client -rs &

# more settings
if [ $scheme = "light" ]; then
    # kitty config
    kitty -1 sh -c "kitty @ set-colors -a -c ~/.config/kitty/themes/light.conf" &
    # zathura
    mv ~/.config/zathura/zathurarc.light ~/.config/zathura/zathurarc
    # qt5ct and qt6ct
    cp ~/.config/qt5ct/light.conf ~/.config/qt5ct/qt5ct.conf
    cp ~/.config/qt6ct/light.conf ~/.config/qt6ct/qt6ct.conf
    # gtk2
    cp ~/.config/gtk-2.0/light.conf ~/.gtkrc-2.0
    # set wallpaper location
    unlink ~/.config/sway/Wallpaper
    ln -s ~/Pictures/wall/sway/light ~/.config/sway/Wallpaper
else
    # kitty config
    kitty -1 sh -c "kitty @ set-colors -a -c ~/.config/kitty/themes/dark.conf" &
    # zathura
    mv ~/.config/zathura/zathurarc.dark ~/.config/zathura/zathurarc
    # qt5ct and qt6ct
    cp ~/.config/qt5ct/dark.conf ~/.config/qt5ct/qt5ct.conf
    cp ~/.config/qt6ct/dark.conf ~/.config/qt6ct/qt6ct.conf
    # gtk2
    cp ~/.config/gtk-2.0/dark.conf ~/.gtkrc-2.0
    # set dark wallpaper
    unlink ~/.config/sway/Wallpaper
    ln -s ~/Pictures/wall/sway/dark ~/.config/sway/Wallpaper
fi

sway reload
