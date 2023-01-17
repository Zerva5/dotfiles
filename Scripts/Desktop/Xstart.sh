#!/bin/bash

xrandr --output DP-2 --primary


xrandr --output DVI-D-0 --off --output HDMI-0 --mode 1920x1080 --pos 0x0 --rotate right --output HDMI-1 --off --output DP-2 --mode 3840x2160 --pos 1080x0 --rotate normal --output DP-1 --off --output DP-2 --off

xset dpms 300 0 0

#export GDK_DPI_SCALE=1.5
