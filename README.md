# Dotfiles

Minimalist sway desktop with `gruvbox` color scheme, following the KISS philosophy.

## Features

- Terminal centric, keyboard based navigation. Optional mouse support on `waybar`
- Scripts for day to day operations: power management, and
- Theme support: has `gruvbox` dark and light variant, fully themed, and toggleable via script

## Screenshots

![code](https://github.com/rywng/dotfiles/assets/72336775/2101a2b3-240f-4c18-9bd4-630c1d4c9036)
![blank](https://github.com/rywng/dotfiles/assets/72336775/c8626d9b-2ea1-4576-946d-883fb5b3688f)

<details>
<summary>Old Screenshots</summary>
<br>

These are screenshots I took 2 years ago when I was using [serenade](https://github.com/rywng/dotfiles/commit/85e37a124be69b2c9366c6745204457c91cb8871) :)

Kept them around because they look quite good

![terminal](https://user-images.githubusercontent.com/72336775/176679848-a66143cb-0df8-4fd0-a567-66693c33741e.png)
![blank](https://user-images.githubusercontent.com/72336775/176679629-c8da017a-2daf-4871-a34f-75bcd3738e28.png)

</details>

## Installing

I use [yadm](https://github.com/TheLocehiliosan/yadm) to manage dotfiles, the directory layout is unchanged so that you can simply clone this.

```bash
yadm clone https://github.com/rywng/dotfiles
```

## Software included

This list may be out-dated, check `.config/` folder for more.

| Name      | Description                         |
| --------- | ----------------------------------- |
| `fuzzel`  | App launcher & `dmenu` alternative  |
| `kitty`   | Terminal emulator                   |
| `mpv`     | Video player                        |
| `swayNC`  | Notification center                 |
| `swayWM`  | Stupid simple and stable Wayland WM |
| `waybar`  | Bar                                 |
| `zathura` | PDF viewer                          |
| `zsh`     | Interactive Shell                   |

## Dependencies

| Name                          | Description                                                                             |
| ----------------------------- | --------------------------------------------------------------------------------------- |
| `acpilight`                   | CLI for managing backlight                                                              |
| `gui-apps/qt6ct`              | To configure qt themes                                                                  |
| `kde-frameworks/breeze-icons` | Icons for qt                                                                            |
| `pipewire`                    | Sound and screen sharing under Wayland                                                  |
| `playerctld`                  | Control players, and show current playing                                               |
| `wireplumber`                 | media session management (remember to replace it in sway's config if using non-systemd) |
| `wlsunset`                    | Shift blue color based on time (Protects my eyes)                                       |
| `wob`                         | show screen backlight and audio output volume level                                     |
