# Dotfiles

Linux desktop with gruvbox colorscheme, following the KISS philosophy.

## TODO

- [ ] Use [zim](https://github.com/zimfw/zimfw) 
- [ ] Update screenshots (It's using serenade instead of gruvbox)

# Screenshots

![terminal](https://user-images.githubusercontent.com/72336775/176679848-a66143cb-0df8-4fd0-a567-66693c33741e.png)
![blank](https://user-images.githubusercontent.com/72336775/176679629-c8da017a-2daf-4871-a34f-75bcd3738e28.png)

# Installing

I use [yadm](https://github.com/TheLocehiliosan/yadm) to manage dotfiles, the directory layout is unchanged.

```bash
yadm clone https://github.com/JuanCldCmt/dotfiles
```

# Software

| Name | Description |
|------|-------------|
|hyprland|wayland WM with better nvidia support|
|waybar|Custom bar for sway|
|swayNC|Notification center|
|wofi|App launcher|
|kitty|Terminal emulator|
|zsh|Interactive Shell|
|mpv|Video player|
|zathura|PDF viewer|

# Depencencies

|Name|Description|
|----|-----------|
|wlsunset|Shift blue color based on time|
|light|CLI for managing backlight|
|pipewire|Sound deamon|
|wireplumber|media session management (remember to replace it in sway's config if using non-gentoo)|
|playerctld|Control players|
