#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

alias dots="cd ~/dotfiles"

alias scripts="cd ~/dotfiles/Scripts"

alias school="cd ~/Documents/School/T1Y1"

alias qgit="sh ~/dotfiles/Scripts/General/githelp.sh"

alias srecord="sh ~/dotfiles/Scripts/General/wcrecord.sh"
