#!/bin/bash

EXTERNAL_MONITORS=$(xrandr | grep -v "eDP" | grep -e " connected" | wc -l)

if [ "$EXTERNAL_MONITORS" -eq 3 ]; then
	xrandr --output eDP-1 --off --output DP-1 --off --output HDMI-1 --off --output DP-2 --off --output DP-3 --off --output DP-4 --off --output DP-2-1 --mode 2560x1440 --pos 0x0 --rotate normal --rate 74.97 --output DP-2-2 --mode 2560x1440 --pos 5120x0 --rotate normal --rate 74.97 --output DP-2-3 --mode 2560x1440 --pos 2560x0 --rotate normal --rate 74.97 --primary
	echo "Applied office desk monitor setup";
	exit 0;
fi

if [ "$EXTERNAL_MONITORS" -eq 2 ]; then
	# create config for two monitors
	xrandr --output eDP-1 --off --output DP-1 --off --output HDMI-1 --off --output DP-2 --mode 1920x1080 --pos 1920x0 --rotate normal --output DP-3 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output DP-4 --off
	echo "Applied home desk monitor setup"
	exit 0;
fi


# when no external monitors are attached, set builtin display
xrandr --output eDP-1 --pos 0x0 --rotate normal --mode 2560x1600 --primary
