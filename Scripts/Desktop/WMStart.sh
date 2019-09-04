#!/bin/bash

compton &
nm-applet &
xset led 3

eval $(ssh-agent)
