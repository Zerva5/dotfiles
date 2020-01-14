#/bin/sh

OUT=$(date +"%F_%T")
MONITOR=$1

echo $OUT

#mss -m 1 -o /home/lmayall/Documents/Photos/$MONITOR

mss -m $MONITOR -o /home/lmayall/Documents/Photos/$OUT