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

sed -i $command ~/.config/sway/config.d/theme
sed -i $command ~/.config/sway/config.d/display
sed -i $command ~/.config/waybar/style.css
sed -i $command ~/.config/kitty/kitty.conf

# more settings
if [ $scheme = "light" ]; then
  kitty -1 sh -c "kitty @ set-colors -a -c ~/.config/kitty/themes/light.conf" &
else
  kitty -1 sh -c "kitty @ set-colors -a -c ~/.config/kitty/themes/dark.conf" &
fi

sway reload
