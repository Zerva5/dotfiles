#!/bin/bash

xrandr --output HDMI-A-0 --primary
# xrandr --output HDMI-A-0 --left-of DisplayPort-0 # 

# xrandr --output DisplayPort-0 --gamma 1.1:1:0.95
# xrandr --output HDMI-A-0 --gamma 1:1:1

xset s off

xset dpms 0 0 0

