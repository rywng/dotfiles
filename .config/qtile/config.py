# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

from typing import List  # noqa: F401

from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

mod = "mod4"
terminal = "kitty"

keys = [

    # Sound
    Key([], "XF86AudioMute", lazy.spawn("amixer set Master toggle")),
    Key([], "XF86AudioLowerVolume", lazy.spawn("amixer set Master 1- unmute")),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("amixer set Master 1+ unmute")),
    Key([], "XF86AudioMicMute", lazy.spawn("amixer set Capture toggle")),

    #screenshots
    Key([mod], "Print",
        lazy.spawn(
            "escrotum ~/Pictures/Screenshots/%Y-%m-%d-%T-screenshot.png")),

    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod],
        "Tab",
        lazy.layout.next(),
        desc="Move window focus to other window"),

    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"],
        "h",
        lazy.layout.shuffle_left(),
        desc="Move window to the left"),
    Key([mod, "shift"],
        "l",
        lazy.layout.shuffle_right(),
        desc="Move window to the right"),
    Key([mod, "shift"],
        "j",
        lazy.layout.shuffle_down(),
        desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),

    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"],
        "h",
        lazy.layout.grow_left(),
        desc="Grow window to the left"),
    Key([mod, "control"],
        "l",
        lazy.layout.grow_right(),
        desc="Grow window to the right"),
    Key([mod, "control"],
        "j",
        lazy.layout.grow_down(),
        desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack"),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),

    # Toggle between different layouts as defined below
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "control"], "r", lazy.restart(), desc="Restart Qtile"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod],
        "r",
        lazy.spawncmd(),
        desc="Spawn a command using a prompt widget"),
    Key([mod, "shift"],
        "Return",
        lazy.spawn("rofi -show drun"),
        desc="launch rofi"),
]

groups = [Group(i) for i in "123456789"]

for i in groups:
    keys.extend([
        # mod1 + letter of group = switch to group
        Key([mod],
            i.name,
            lazy.group[i.name].toscreen(),
            desc="Switch to group {}".format(i.name)),

        # mod1 + shift + letter of group = switch to & move focused window to group
        Key([mod, "shift"],
            i.name,
            lazy.window.togroup(i.name, switch_group=True),
            desc="Switch to & move focused window to group {}".format(i.name)),
        # Or, use below if you prefer not to switch to that group.
        # # mod1 + shift + letter of group = move focused window to group
        # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
        #     desc="move focused window to group {}".format(i.name)),
    ])

layouts = [
    #layout.Columns(border_focus_stack='#b48ead'),
    #layout.Max(),
    # Try more layouts by unleashing below layouts.
    #layout.Stack(num_stacks=2),
    #layout.Bsp(),
    #layout.Matrix(),
    #layout.MonadTall(),
    #layout.MonadWide(),
    #layout.RatioTile(),
    #layout.Tile(),
    #layout.TreeTab(),
    #layout.VerticalTile(),
    #layout.Zoomy(),
    layout.Columns(
        border_focus='#b48ead',
        border_normal_stack='#8fbcbb',
        border_normal='#3b4252',
        margin=0,
        margin_on_single=0,
    ),
]

fgc1 = '#d8dee9'
fgc2 = '#eceff4'

widget_defaults = dict(
    font='monospace',
    fontsize=16,
    padding=3,
    foreground=fgc1,
    margin_y=2,
)
extension_defaults = widget_defaults.copy()

# Bar and widgets

bgc1 = '#2e3440'
bgc2 = '#3b4252'

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.Sep(padding=6, linewidth=0, background=bgc1),
                widget.GroupBox(background=bgc1,
                                active=fgc1,
                                highlight_method='line',
                                highlight_color=['b48ead'],
                                borderwidth=2,
                                this_current_screen_border='5e81ac',
                                this_screen_border='81a1c1',
                                disable_drag=True),
                widget.Prompt(background=bgc1),
                widget.Sep(padding=12, background=bgc1, linewidth=0),
                widget.Sep(padding=12, background=bgc2, linewidth=0),
                widget.WindowName(
                    font='sans', background=bgc2, foreground=fgc2),
                widget.Chord(
                    chords_colors={
                        'launch': (bgc1, fgc1),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                widget.Sep(padding=12, background=bgc1, linewidth=0),
                widget.Notify(background=bgc1,
                              foreground=fgc1,
                              foreground_low='e5e9f0',
                              foreground_urgent='d08770',
                              padding=6),
                widget.Sep(padding=24, background=bgc1),
                widget.Systray(background=bgc1),
                widget.Sep(padding=24, background=bgc1),
                widget.TextBox(text='Vol:[', background=bgc1),
                widget.Volume(background=bgc1),
                widget.TextBox(background=bgc1, text=']'),
                widget.Sep(padding=6, linewidth=0, background=bgc1),
                widget.Net(format='Dl:[{down}] ', background=bgc1),
                widget.CPU(format='Freq:[{freq_current}GHz] ',
                           background=bgc1),
                widget.Battery(format='Bat:[{char}{percent:2.0%} {watt:.1f}W]',
                               background=bgc1),
                widget.Sep(padding=12, background=bgc1, linewidth=0),
                widget.Sep(padding=12, background=bgc1, linewidth=0),
                widget.Clock(background=bgc1, format='%H:%M'),
                widget.Sep(padding=24, linewidth=0, background=bgc1),
            ],
            24,
        ),
        #wallpaper="~/Pictures/Wallpapers/sunset.jpg",
        #wallpaper_mode='fill'
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod],
         "Button1",
         lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod],
         "Button3",
         lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None  # WARNING: this is deprecated and will be removed soon
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    *layout.Floating.default_float_rules,
    Match(wm_class='confirmreset'),  # gitk
    Match(wm_class='makebranch'),  # gitk
    Match(wm_class='maketag'),  # gitk
    Match(wm_class='ssh-askpass'),  # ssh-askpass
    Match(title='branchdialog'),  # gitk
    Match(title='pinentry'),  # GPG key password entry
])
auto_fullscreen = True
focus_on_window_activation = "smart"
wmname = "LG3D"

#auto lock
#lazy.spawn('xautolock -time 12 -locker "slock systemctl suspend" -detectslee')
