scheme=$(echo "light\ndark" | wofi -d -p "Select color scheme")

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
  kitty -1 sh -c "kitty @ set-colors -a -c ~/.config/kitty/themes/light.conf" &
  mv ~/.config/zathura/zathurarc.light ~/.config/zathura/zathurarc
  
  # set wallpaper location
  unlink ~/.config/sway/Wallpaper
  ln -s ~/Pictures/Wallpapers/light ~/.config/sway/Wallpaper
else
  kitty -1 sh -c "kitty @ set-colors -a -c ~/.config/kitty/themes/dark.conf" &
  mv ~/.config/zathura/zathurarc.dark ~/.config/zathura/zathurarc

  # set dark wallpaper
  unlink ~/.config/sway/Wallpaper
  ln -s ~/Pictures/Wallpapers/dark ~/.config/sway/Wallpaper
fi

sway reload
