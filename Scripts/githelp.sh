#!/bin/bash

ACTION=$1

REPO=$2

ARGUMENT=$3

REPOPATH=""

function pull {
	git -C $REPOPATH pull
}

function push {

	if [ -n "$ARGUMENT" ];
	then
		
		git -C $REPOPATH add -A
	
		git -C $REPOPATH commit -m "$ARGUMENT"

		git -C $REPOPATH push origin master
	else
		echo "NO COMMIT MESSAGE"
		exit 1
	fi
}

case "$REPO" in
	"dotfiles")
	REPOPATH="/home/lmayall/dotfiles" ;;
esac

if [ $ACTION == "push" ];
then
	push
elif [ $ACTION == "pull" ];
then
	pull
fi

exit 0
