#!/bin/bash

nohup picom &
nm-applet &

export TEST=5

eval $(ssh-agent)
