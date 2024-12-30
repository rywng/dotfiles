#!/usr/bin/env sh
scheme=$(/bin/echo -e "light\ndark" | fuzzel -d -p "󰔎 : ")

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
# kitty config
kitty -1 sh -c "kitty @ set-colors -a -c ~/.config/kitty/themes/$scheme.conf" &
# zathura
ln -sf ~/.config/zathura/zathurarc.$scheme ~/.config/zathura/zathurarc
# fuzzel
ln -sf ~/.config/fuzzel/fuzzel-$scheme.ini ~/.config/fuzzel/fuzzel.ini
# qt5ct and qt6ct
ln -sf ~/.config/qt5ct/$scheme.conf ~/.config/qt5ct/qt5ct.conf
ln -sf ~/.config/qt6ct/$scheme.conf ~/.config/qt6ct/qt6ct.conf
# gtk2
ln -sf ~/.config/gtk-2.0/$scheme.conf ~/.gtkrc-2.0
# gtk3
ln -sf ~/.config/gtk-3.0/$scheme.ini ~/.config/gtk-3.0/settings.ini

swaymsg reload
systemctl --user restart waybar.service
