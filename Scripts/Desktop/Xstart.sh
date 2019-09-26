#!/bin/bash

xset led 3

xrandr --output HDMI-A-0 --primary
xrandr --output HDMI-A-0 --left-of DisplayPort-0
