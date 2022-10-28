#!/bin/bash

xrandr --output DP-0 --primary
#xrandr --output DP-0 --right-of HDMI-0


#xrandr --output HDMI-0 --rotate right
# xrandr --output HDMI-A-0 --left-of DisplayPort-0 # 

# xrandr --output DisplayPort-0 --gamma 1.1:1:0.95
# xrandr --output HDMI-A-0 --gamma 1:1:1

#xrandr --output DVI-D-0 --off --output HDMI-0 --mode 1920x1080 --pos 0x0 --rotate right --output HDMI-1 --off --output DP-2 --off --output DP-1 --off --output DP-0 --mode 3840x2160 --pos 1080x0 --rotate normal --output DP-3 --off

xrandr --output DVI-D-0 --off --output HDMI-0 --mode 1920x1080 --pos 0x0 --rotate right --output HDMI-1 --off --output DP-2 --mode 3840x2160 --pos 1080x0 --rotate normal --output DP-1 --off --output DP-0 --off
#xset s off

xset dpms 300 0 0


#export GDK_DPI_SCALE=1.5
