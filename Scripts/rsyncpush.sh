#!/bin/bash 

if [ $(hostname) == "LMDESK" ]
then
	rsync -a --delete --quiet -e ssh /home/lmayall/Documents/School/ lmayall@LMTHINK.local:/home/lmayall/Documents/School
	rsync -a --delete --quiet -e ssh /home/lmayall/vimwiki/ lmayall@LMTHINK.local:/home/lmayall/vimwiki

elif [ $(hostname) == "LMTHINK" ]
then
	rsync -a --delete --quiet -e ssh /home/lmayall/Documents/School/ lmayall@LMDESK.local:/home/lmayall/Documents/School

fi
