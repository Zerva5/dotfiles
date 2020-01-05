#!/bin/bash

INCR=$2
BRIGHT=${1%.*}

echo $1
echo $INCR
echo $BRIGHT

if [ "$INCR" -gt "0" ] && [ "$BRIGHT" -lt "100" ]; then
  echo DOWN
  NEWBRIGHT="$(echo "($BRIGHT + $INCR)/100.0" | bc -l)"
  xrandr --output HDMI-A-0 --brightness $NEWBRIGHT && xrandr --output DisplayPort-0 --brightness $NEWBRIGHT

elif [ $INCR -lt "0" ] && [ "$BRIGHT" -gt "0" ]; then
  echo UP
  NEWBRIGHT="$(echo "($BRIGHT + $INCR)/100.0" | bc -l)"

  xrandr --output HDMI-A-0 --brightness $NEWBRIGHT && xrandr --output DisplayPort-0 --brightness $NEWBRIGHT
else
  echo NONE
fi


