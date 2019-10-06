#!/bin/bash

compton --config ~/.config/compton/compton.conf &
nm-applet &
xset led 3

xrandr --output HDMI-A-0 --primary
xrandr --output HDMI-A-0 --left-of DisplayPort-0

xrandr --output DisplayPort-0 --gamma 0.9:.85:.9
xrandr --output HDMI-A-0 --gamma 1:1.1:1.1

eval $(ssh-agent)
