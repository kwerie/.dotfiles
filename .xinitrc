#!/bin/sh

# /etc/X11/xinit/xinitrc
#
# global xinitrc file, used by all X sessions started by xinit (startx)

# invoke global X session script
. /etc/X11/Xsession


# Set screen resolution
xrandr --auto --output DP-1 --mode 1920x1080
xrandr --auto --output DP-3 --mode 1920x1080

xrdb ~/.Xresources
