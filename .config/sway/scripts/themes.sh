#!/usr/bin/env bash
scheme=$(echo -e "light\ndark" | fuzzel -d -p "󰔎 : ")

# simply subsitude dark and light
if [ $scheme = "light" ]; then
    command="s/dark/light/"
elif [ $scheme = "dark" ]; then
    command="s/light/dark/"
else
    exit 1
fi

sed -i $command ~/.config/kitty/kitty.conf
sed -i $command ~/.config/sway/conf.d/theme
sed -i $command ~/.config/swaync/style.css
sed -i $command ~/.config/waybar/style.css

swaync-client -rs &

# more settings
if [ $scheme = "light" ]; then
    # kitty config
    kitty -1 sh -c "kitty @ set-colors -a -c ~/.config/kitty/themes/light.conf" &
    # fuzzel
    cp ~/.config/fuzzel/fuzzel-light.ini ~/.config/fuzzel/fuzzel.ini
    # zathura
    cp ~/.config/zathura/zathurarc.light ~/.config/zathura/zathurarc
    # qt5ct and qt6ct
    cp ~/.config/qt5ct/light.conf ~/.config/qt5ct/qt5ct.conf
    cp ~/.config/qt6ct/light.conf ~/.config/qt6ct/qt6ct.conf
    # gtk2
    cp ~/.config/gtk-2.0/light.conf ~/.gtkrc-2.0
    # gtk3
    cp ~/.config/gtk-3.0/light.ini ~/.config/gtk-3.0/settings.ini
else
    # kitty config
    kitty -1 sh -c "kitty @ set-colors -a -c ~/.config/kitty/themes/dark.conf" &
    # zathura
    cp ~/.config/zathura/zathurarc.dark ~/.config/zathura/zathurarc
    # fuzzel
    cp ~/.config/fuzzel/fuzzel-dark.ini ~/.config/fuzzel/fuzzel.ini
    # qt5ct and qt6ct
    cp ~/.config/qt5ct/dark.conf ~/.config/qt5ct/qt5ct.conf
    cp ~/.config/qt6ct/dark.conf ~/.config/qt6ct/qt6ct.conf
    # gtk2
    cp ~/.config/gtk-2.0/dark.conf ~/.gtkrc-2.0
    # gtk3
    cp ~/.config/gtk-3.0/dark.ini ~/.config/gtk-3.0/settings.ini
fi

swaymsg reload
systemctl --user restart waybar.service
