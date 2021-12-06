#!/bin/sh

. "$THEME"

#############
## VARIOUS ##
#############

# Xresources for dwm colors
xrdb "$XRESOURCES"

# personal init script
# needs to be created manually
[ -f "$XDG_CONFIG_HOME/bedsi/init" ] && "$XDG_CONFIG_HOME/bedsi/init"

############################
## INPUT DEVICES SETTINGS ##
############################

# setting correct mouse cursor
xsetroot -cursor_name left_ptr

# adding tab as a modifier key for use in certain hotkeys
xmodmap -e "add mod3 = Tab"

# increase key speed
xset r rate 300 50

##############
## PROGRAMS ##
##############

# hiding inactive cursor
unclutter &

# playerctl for controlling media players with hotkeys
playerctld daemon &

# wallpaper
nitrogen --restore &

# statusbar scripts for dwm panel
# (forked so it can be restarted without killing dwm)
setsid dwm-status &

# launching window manager
exec dwm
