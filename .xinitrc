#!/bin/sh

. "$THEME"

###############
### VARIOUS ###
###############

# Xresources for dwm colors
xrdb "$XRESOURCES"

##############################
### INPUT DEVICES SETTINGS ###
##############################

# setting correct mouse cursor
xsetroot -cursor_name left_ptr

# setting my keyboard layout in this separate script
# script needs to be created manually
# setxkbmap is a good program for this
[ -f "$XDG_CONFIG_HOME/bedsi/keyboard" ] && "$XDG_CONFIG_HOME/bedsi/keyboard"

# adding tab as a modifier key for use in certain hotkeys
xmodmap -e "add mod3 = Tab"

# increase key speed
xset r rate 300 50

################
### PROGRAMS ###
################

# hiding inactive cursor
unclutter &

# playerctl for controlling media players with hotkeys
playerctld daemon &

# statusbar scripts for dwm panel
# (forked so it can be restarted without killing dwm)
setsid dwm-status &

# launching window manager
exec dwm
