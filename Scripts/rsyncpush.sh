#!/bin/bash 

if [ $(hostname) == "LMDESK" ]
then
	rsync -a --delete --quiet -e ssh /home/lmayall/Documents/School/ lmayall@LMTHINK.local:/home/lmayall/Documents/School
	rsync -a --delete --quiet -e ssh /home/lmayall/vimwiki/ lmayall@LMTHINK.local:/home/lmayall/vimwiki
	rsync -a --delete --quiet -e ssh /home/lmayall/.config/nvim/ lmayall@LMTHINK.local:/home/lmayall/.config/nvim
	rsync -a --delete --quiet -e ssh /home/lmayall/todo/ lmayall@LMTHINK.local:/home/lmayall/todo
	

elif [ $(hostname) == "LMTHINK" ]
then
	rsync -a --delete --quiet -e ssh /home/lmayall/Documents/School/ lmayall@LMDESK.local:/home/lmayall/Documents/School
	rsync -a --delete --quiet -e ssh /home/lmayall/vimwiki/ lmayall@LMDESK.local:/home/lmayall/vimwiki
	rsync -a --delete --quiet -e ssh /home/lmayall/.config/nvim/ lmayall@LMDESK.local:/home/lmayall/.config/nvim
	rsync -a --delete --quiet -e ssh /home/lmayall/todo/ lmayall@LMDESK.local:/home/lmayall/todo
	#rsync -a --delete --quiet -e ssh /home/lmayall/.config/nvim/ lmayall@LMDESK.local:/home/lmayall/.config/nvim
	#rsync -a --delete --quiet -e ssh /home/lmayall/.config/nvim/ lmayall@LMDESK.local:/home/lmayall/.config/nvim


fi
