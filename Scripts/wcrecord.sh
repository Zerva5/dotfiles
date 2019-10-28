#/bin/bash

DAY=`date "+%d-%m-%y"`
PATH="/home/lmayall/Documents/records/"

/usr/bin/ffmpeg -f v4l2 -video_size 480x360 -i /dev/video0 -f alsa -i default -c:v libx264 -preset ultrafast -c:a aac $PATH$DAY.mp4
