#!/bin/sh

#if [ "$1" == "LMTHINK" ]
#then
rsync -a --delete --quiet -e ssh /home/lmayall/Documents/School/ lmayall@LMTHINK.local:/home/lmayall/Documents/School
#elif [ "$1" == "LMDESK" ]
#then
#	rsync -a --delete --quiet -e ssh /home/lmayall/Documents/School/ lmayall@LMDESK.local:/home/lmayall/Documents/School
#fi
