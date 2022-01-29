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

# statusbar script for dwm panel
rnstatus start &

# launching window manager
exec dwm
