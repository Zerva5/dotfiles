#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

alias dots="cd ~/dotfiles"

alias awesome="cd ~/dotfiles/config/awesome"

alias scripts="cd ~/dotfiles/Scripts"

alias school="cd ~/Documents/School/T2Y1"

alias qgit="sh ~/dotfiles/Scripts/General/githelp.sh"

alias emacs-reload="systemctl stop --user emacs; systemctl start --user emacs"

alias srecord="sh ~/dotfiles/Scripts/General/wcrecord.sh"

alias mounthome="sudo mount -t nfs 206.87.86.221:/home/lmayall/storage /home/lmayall/Network/lmhome"

alias keylight="xset led 3"
