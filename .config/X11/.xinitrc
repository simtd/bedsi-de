#!/bin/sh

#############
## VARIOUS ##
#############

xrdb "$XRESOURCES"

# Personal init script
# Needs to be created manually
[ -f "$XDG_CONFIG_HOME/bedsi/init" ] && "$XDG_CONFIG_HOME/bedsi/init"

############################
## INPUT DEVICES SETTINGS ##
############################

# Setting correct mouse cursor
xsetroot -cursor_name left_ptr

# Increase key speed
xset r rate 300 50

##############
## PROGRAMS ##
##############

# Hiding inactive cursor
unclutter &

# Playerctl for controlling media players with hotkeys
playerctld daemon &

# Wallpaper
nitrogen --restore &

# Statusbar script for dwm panel
rnstatus start &

# Launching window manager
exec dwm
