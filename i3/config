# i3 config file (v4)
#
# Please see https://i3wm.org/docs/userguide.html for a complete reference!
#
# This config file uses keycodes (bindsym) and was written for the QWERTY
# layout.
#
# To get a config file with the same key positions, but for your current
# layout, use the i3-config-wizard
#

# Font for window titles. Will also be used by the bar unless a different font
# is used in the bar {} block below.
set $mod Mod4
set $editor vim

# Use custom colors for black
set $black       #282828
set $darkblack   #1d2021
set $transparent #00000000

set $darkred      #7d0202
set $red          #fd0000
set $darkgreen    #026700
set $green        #17B501
set $darkyellow   #B9C000
set $yellow       #FCE302
set $darkblue     #00019E
set $blue         #0096FF
set $darkmagenta  #A20099
set $magenta      #DB00FF
set $darkcyan     #0079B8
set $cyan         #00E3FF
set $darkwhite    #EAEAEA
set $white        #FFFFFF

set $base00 #1d2021
set $base01 #3c3836
set $base02 #504945
set $base03 #665c54
set $base04 #bdae93
set $base05 #d5c4a1
set $base06 #ebdbb2
set $base07 #fbf1c7
set $base08 #fb4934
set $base09 #fe8019
set $base0A #fabd2f
set $base0B #b8bb26
set $base0C #8ec07c
set $base0D #83a598
set $base0E #d3869b
set $base0F #d65d0e

set $height 34

set $ws1  1
set $ws2  2
set $ws3  3
set $ws4  4
set $ws5  5
set $ws6  6
set $ws7  7
set $ws8  8
set $ws9  9
set $ws10 10

# define output 
set $screen1 = "eDP1"
set $screen2 = "DP1-2-8"
set $screen3 = "DP1-2-1-8"

workspace $ws1 output $screen1 
workspace $ws2 output $screen1
workspace $ws3 output $screen2
workspace $ws4 output $screen2
workspace $ws5 output $screen2
workspace $ws6 output $screen2
workspace $ws7 output $screen3
workspace $ws8 output $screen3
workspace $ws9 output $screen3
workspace $ws10 output $screen3

#GAP configuration 
set $gaps_i 6
set $gaps_o 6

gaps inner $gaps_i
gaps outer $gaps_o

workspace $ws1 gaps inner $gaps_i
workspace $ws1 gaps outer $gaps_o
workspace $ws2 gaps inner $gaps_i
workspace $ws2 gaps outer $gaps_o
workspace $ws3 gaps inner $gaps_i
workspace $ws3 gaps outer $gaps_o
workspace $ws4 gaps inner $gaps_i
workspace $ws4 gaps outer $gaps_o
workspace $ws5 gaps inner $gaps_i
workspace $ws5 gaps outer $gaps_o
workspace $ws6 gaps inner $gaps_i
workspace $ws6 gaps outer $gaps_o
workspace $ws7 gaps inner $gaps_i
workspace $ws7 gaps outer $gaps_o
workspace $ws8 gaps inner $gaps_i
workspace $ws8 gaps outer $gaps_o
workspace $ws9 gaps inner $gaps_i
workspace $ws9 gaps outer $gaps_o
workspace $ws10 gaps inner $gaps_i
workspace $ws10 gaps outer $gaps_o

workspace_auto_back_and_forth yes
force_display_urgency_hint 0 ms
focus_on_window_activation urgent

floating_minimum_size -1 x -1
floating_maximum_size -1 x -1

font pango:Hack, FontAwesome 12

# Settings to show the border
#border pixel 3
#                       BORDER      BACKGROUND  TEXT        INDICATOR   CHILD_BORDER
#client.focused          $green      $black      $darkwhite  $blue       $green
#client.unfocused        $darkgreen  $black      $white      $blue       $darkgreen
#client.focused_inactive $darkblue   $black      $white      $blue       $darkgreen
#client.urgent           $darkred    $darkred    $black      $darkred    $darkred
#client.background       $black


# Basic color configuration using the Base16 variables for windows and borders.
# Property Name         Border  BG      Text    Indicator Child Border
client.focused          $base05 $base0D $base00 $base0D $base0C
client.focused_inactive $base01 $base01 $base05 $base03 $base01
client.unfocused        $base01 $base00 $base05 $base01 $base01
client.urgent           $base08 $base08 $base00 $base08 $base08
client.placeholder      $base00 $base00 $base05 $base00 $base00
client.background       $base07

# class                 border  bground text    indicator child_border
#client.focused          #4C7899 #285577 #FFFFFF #2E9EF4   #285577
#client.focused_inactive #333333 #5F676A #FFFFFF #484E50   #5F676A
#client.unfocused        #333333 #222222 #888888 #292D2E   #222222
#client.urgent           #2F343A #900000 #FFFFFF #900000   #900000
#client.placeholder      #000000 #0C0C0C #FFFFFF #000000   #0C0C0C

floating_modifier $mod


# This font is widely installed, provides lots of unicode glyphs, right-to-left
# text rendering and scalability on retina/hidpi displays (thanks to pango).
#font pango:DejaVu Sans Mono 14

# Before i3 v4.8, we used to recommend this one as the default:
# font -misc-fixed-medium-r-normal--13-120-75-75-C-70-iso10646-1
# The font above is very space-efficient, that is, it looks good, sharp and
# clear in small sizes. However, its unicode glyph coverage is limited, the old
# X core fonts rendering does not support right-to-left and this being a bitmap
# font, it doesn't scale on retina/hidpi displays.

# use these keys for focus, movement, and resize directions when reaching for
# the arrows is not convenient
set $up k
set $down j
set $left n
set $right l 

# use Mouse+$mod to drag floating windows to their wanted position
floating_modifier $mod

# start a terminal
bindsym $mod+Return exec i3-sensible-terminal -e fish
bindszm $mod+Control+z exec i3-sensible-terminal termite 

# kill focused window
bindsym $mod+Shift+q kill

# start dmenu (a program launcher)
#bindsym $mod+d exec dmenu_run
# There also is the (new) i3-dmenu-desktop which only displays applications
# shipping a .desktop file. It is a wrapper around dmenu, so you need that
# installed.
#bindsym $mod+d exec --no-startup-id i3-dmenu-desktop --dmenu='dmenu -fn "Input Mono Regular-12"'
bindsym $mod+d exec --no-startup-id rofi -show run

# change focus
bindsym $mod+$left focus left
bindsym $mod+$down focus down
bindsym $mod+$up focus up
bindsym $mod+$right focus right

# alternatively, you can use the cursor keys:
bindsym $mod+Left focus left
bindsym $mod+Down focus down
bindsym $mod+Up focus up
bindsym $mod+Right focus right

# move focused window
bindsym $mod+Shift+$left move left
bindsym $mod+Shift+$down move down
bindsym $mod+Shift+$up move up
bindsym $mod+Shift+$right move right

# alternatively, you can use the cursor keys:
bindsym $mod+Shift+Left move left
bindsym $mod+Shift+Down move down
bindsym $mod+Shift+Up move up
bindsym $mod+Shift+Right move right

# split in horizontal orientation
bindsym $mod+h split h

# split in vertical orientation
bindsym $mod+v split v

# enter fullscreen mode for the focused container
bindsym $mod+f fullscreen toggle

# change container layout (stacked, tabbed, toggle split)
bindsym $mod+s layout stacking
bindsym $mod+w layout tabbed
bindsym $mod+e layout toggle split

# toggle tiling / floating
bindsym $mod+Shift+space floating toggle

# change focus between tiling / floating windows
bindsym $mod+space focus mode_toggle

# focus the parent container
bindsym $mod+a focus parent

# focus the child container
#bindsym $mod+d focus child

# move the currently focused window to the scratchpad
bindsym $mod+Shift+minus move scratchpad

# Show the next scratchpad window or hide the focused scratchpad window.
# If there are multiple scratchpad windows, this command cycles through them.
bindsym $mod+minus scratchpad show

# Define names for default workspaces for which we configure key bindings later on.
# We use variables to avoid repeating the names in multiple places.


# switch to workspace
bindsym $mod+1 workspace $ws1
bindsym $mod+2 workspace $ws2
bindsym $mod+3 workspace $ws3
bindsym $mod+4 workspace $ws4
bindsym $mod+5 workspace $ws5
bindsym $mod+6 workspace $ws6
bindsym $mod+7 workspace $ws7
bindsym $mod+8 workspace $ws8
bindsym $mod+9 workspace $ws9
bindsym $mod+0 workspace $ws10
bindsym $mod+Tab workspace back_and_forth


# move focused container to workspace
bindsym $mod+Shift+1 move container to workspace $ws1
bindsym $mod+Shift+2 move container to workspace $ws2
bindsym $mod+Shift+3 move container to workspace $ws3
bindsym $mod+Shift+4 move container to workspace $ws4
bindsym $mod+Shift+5 move container to workspace $ws5
bindsym $mod+Shift+6 move container to workspace $ws6
bindsym $mod+Shift+7 move container to workspace $ws7
bindsym $mod+Shift+8 move container to workspace $ws8
bindsym $mod+Shift+9 move container to workspace $ws9
bindsym $mod+Shift+0 move container to workspace $ws10


set $mode_power power
bindsym $mod+Control+l mode "$mode_power"
mode "$mode_power" {
    bindsym l mode "default", exec --no-startup-id $HOME/.config/i3/i3lock/lock.sh
    bindsym e mode "default", exec --no-startup-id $HOME/.config/i3/i3exit logout
    bindsym s mode "default", exec --no-startup-id $HOME/.config/i3/i3exit suspend
    bindsym h mode "default", exec --no-startup-id $HOME/.config/i3/i3exit hibernate
    bindsym r mode "default", exec --no-startup-id $HOME/.config/i3/i3exit reboot
    bindsym p mode "default", exec --no-startup-id $HOME/.config/i3/i3exit shutdown

    bindsym Return mode "default"
    bindsym Escape mode "default"
}
# start script launcher
bindsym $mod+ctrl+x exec --no-startup-id $HOME/.scripts/script_runner.sh

# reload the configuration file
bindsym $mod+Shift+c reload
# restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
bindsym $mod+Shift+r restart
# exit i3 (logs you out of your X session)
bindsym $mod+Shift+e exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -B 'Yes, exit i3' 'i3-msg exit'"

# Pulse Audio controll
# increase volume by 5%
bindsym XF86AudioRaiseVolume exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +5%

#decrease volume by 5%
bindsym XF86AudioLowerVolume exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -5%

# mute 
bindsym XF86AudioMute exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle

# schow screen configuration demenu
bindsym $mod+Control+s exec --no-startup-id $HOME/.scripts/displayselect.sh
#bindsym $mod+d exec --no-startup-id "rofi -show drun -font \\"DejaVu 11\\" -run-shell-command '{terminal} -e \\" {cmd}; read -n 1 -s\\"'"
# resize window (you can also use the mouse for that)
mode "resize" {
        # These bindings trigger as soon as you enter the resize mode

        # Pressing left will shrink the window’s width.
        # Pressing right will grow the window’s width.
        # Pressing up will shrink the window’s height.
        # Pressing down will grow the window’s height.
        bindsym $left       resize shrink width 10 px or 10 ppt
        bindsym $down       resize grow height 10 px or 10 ppt
        bindsym $up         resize shrink height 10 px or 10 ppt
        bindsym $right      resize grow width 10 px or 10 ppt

        # same bindings, but for the arrow keys
        bindsym Left        resize shrink width 10 px or 10 ppt
        bindsym Down        resize grow height 10 px or 10 ppt
        bindsym Up          resize shrink height 10 px or 10 ppt
        bindsym Right       resize grow width 10 px or 10 ppt

        # back to normal: Enter or Escape or $mod+r
        bindsym Return mode "default"
        bindsym Escape mode "default"
        bindsym $mod+r mode "default"
}

set $mode_gaps gaps
set $mode_gaps_outer outer gaps
set $mode_gaps_inner inner gaps
bindsym $mod+Shift+g mode "$mode_gaps"
mode "$mode_gaps" {
    bindsym o      mode "$mode_gaps_outer"
    bindsym i      mode "$mode_gaps_inner"

    bindsym 0      mode "default", exec --no-startup-id i3-msg "gaps inner current set 0" && i3-msg "gaps outer current set 0"
    bindsym d      mode "default", exec --no-startup-id i3-msg "gaps inner current set $default_gaps_inner" && i3-msg "gaps outer current set $default_gaps_outer"

    bindsym Return mode "default"
    bindsym Escape mode "default"
}

mode "$mode_gaps_inner" {
    bindsym plus  gaps inner current plus 5
    bindsym minus gaps inner current minus 5
    bindsym 0     mode "default", gaps inner current set 0
    bindsym d     mode "default", gaps inner current set $default_gaps_inner

    bindsym Shift+plus  gaps inner all plus 5
    bindsym Shift+minus gaps inner all minus 5
    bindsym Shift+0     mode "default", gaps inner all set 0
    bindsym Shift+d     mode "default", gaps inner all set $default_gaps_inner

    bindsym Return mode "default"
    bindsym Escape mode "default"
}

mode "$mode_gaps_outer" {
    bindsym plus  gaps outer current plus 5
    bindsym minus gaps outer current minus 5
    bindsym 0     mode "default", gaps outer current set 0
    bindsym d     mode "default", gaps outer current set $default_gaps_outer

    bindsym Shift+plus  gaps outer all plus 5
    bindsym Shift+minus gaps outer all minus 5
    bindsym Shift+0     mode "default", gaps outer all set 0
    bindsym Shift+d     mode "default", gaps outer all set $default_gaps_outer

    bindsym Return mode "default"
    bindsym Escape mode "default"
}

bindsym $mod+r mode "resize"
bindsym $mod+ctrl+w focus output $screen2
bindsym $mod+ctrl+e focus output $screen1
#move focused workspace between monitors
bindsym $mod+ctrl+Right move workspace to output left
bindsym $mod+ctrl+Left move workspace to output right

# fix graphics glitch
new_window none
for_window [class="^.*"] border pixel 3

for_window [window_role="pop-up"] floating enable
for_window [window_role="bubble"] floating enable
for_window [window_role="task_dialog"] floating enable
for_window [window_role="Preferences"] floating enable

for_window [window_type="dialog"] floating enable
for_window [window_type="menu"] floating enable

for_window [class="(?i)gsimplecal"] floating enable, move position mouse, move down $height px
for_window [class="(?i)qemu-system"] floating enable
for_window [class="(?i)VirtualBox" title="(?i)Manager"] floating enable
for_window [class="(?i)VirtualBox"] floating enable
for_window [class="(?i)blueman"] floating enable
for_window [class="(?i)pinentry"] floating enable
for_window [class="(?i)nm-connection-editor"] floating enable

#for_window [instance="sun-awt-X11-XFramePeer"] floating enable
for_window [instance="__scratchpad"] floating enable
for_window [instance="__nmtui"] floating enable
for_window [class="(?i)recordmydesktop"] floating enable
for_window [class="(?i)pavucontrol"] floating enable, move position mouse
for_window [class="(?i)pavucontrol" instance="pavucontrol-bar"] move down $height px

assign [class="(?i)chromium" window_type="normal"]$ws5
assign [class="(?i)neovide" window_type="normal"] $ws4
#assign [class="(?i)eclipse" window_type="normal"] $ws3
assign [class="(?i)thunderbird"]                  $ws9


# Start i3bar to display a workspace bar (plus the system information i3status
# finds out, if available)
#bar {
#    verbose yes
#    status_command i3blocks
#    i3bar_command i3bar -t
#    position top
#    font pango:Hack, FontAwesome 12
#    strip_workspace_numbers yes
#    separator_symbol "■"
#    tray_output eDP-1
#    tray_padding 0
    
#}
exec --no-startup-id $HOME/.scripts/launch_polybar "notebook" &
exec --no-startup-id compton &
exec --no-startup-id feh -z --bg-fill /home/seri/.config/wallpaper/ 
exec --no-startup-id unclutter &
exec --no-startup-id dunst&
