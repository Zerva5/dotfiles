#!/bin/bash

picom &
nm-applet &

eval $(ssh-agent)
