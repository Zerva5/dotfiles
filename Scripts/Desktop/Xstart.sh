#!/bin/bash

xrandr --output DP-0 --primary
xrandr --output DP-0 --left-of HDMI-0


xrandr --output HDMI-0 --rotate left
# xrandr --output HDMI-A-0 --left-of DisplayPort-0 # 

# xrandr --output DisplayPort-0 --gamma 1.1:1:0.95
# xrandr --output HDMI-A-0 --gamma 1:1:1

xset s off

xset dpms 0 0 0


export GDK_DPI_SCALE=1.5
