#!/bin/bash 

if [ $(hostname) == "LMDESK" ]
then
	rsync -a --delete --quiet -e ssh /home/lmayall/Documents/School/ lmayall@LMTHINK.local:/home/lmayall/Documents/School

elif [ $(hostname) == "LMTHINK" ]
then
	rsync -a --delete --quiet -e ssh /home/lmayall/Documents/School/ lmayall@LMDESK.local:/home/lmayall/Documents/School

fi
