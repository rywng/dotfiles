if hyprctl monitors | grep "Lectron Company Ltd LECOO M2412HL GG30A137" &>/dev/null
then
    hyprctl keyword monitor "eDP-1, disable"
else
    hyprctl keyword monitor "eDP-1, 2560x1440@90, auto, auto"
fi
